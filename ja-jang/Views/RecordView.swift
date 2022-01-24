//
//  RecordView.swift
//  ja-jang
//
//  Created by funch on 2022/01/19.
//

import SwiftUI
import Combine

let babyStatus2: Dictionary<String, String> = [
    "sleep": "수면 중",
    "wake_openEyes": "눈 뜸",
    "wake_cyring": "움",
    "wake_whine": "칭얼",
]

struct RecordView: View {
    @State private var babyStatus: String = "수면 중"
    @State private var count: Int = 0
    @State private var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

    func startRecord() {
    }
    
    func record(status: String) {
        let timestamp = timestamp()
        print(timestamp)
        
        let prevStatus = "wake_openEyes"
        
        if (prevStatus.elementsEqual(status)) {
            print("same status" + status)
            return
        }
        
        print("save previous status : " + prevStatus)
    
        switch status {
        case "sleep":
            print("current status : " + status)
            babyStatus = "수면 중"
            print("save current status : " + status)
        case "wake_openEyes":
            print("current status : " + status)
            babyStatus = "눈뜸"
            print("save current status : " + status)
        case "wake_crying":
            print("current status : " + status)
            babyStatus = "움"
            print("save current status : " + status)
        case "wake_whine":
            print("current status : " + status)
            babyStatus = "칭얼"
            print("save current status : " + status)
        default:
            print("current status : " + status)
        }
    }
    
    func timestamp() -> String {
        let currentDate = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let now = dateFormat.string(from: currentDate)
        return now
    }
    
    func start() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    }
    
    func stop() {
        timer.upstream.connect().cancel()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(babyStatus)
            
            Text(String(count)).onReceive(timer) { _ in
                count += 1
            }
            
            Button(action: {
                print(Calendar.current)
                count = 0
                // sleep 모드
                    // Click Event
                    // 1. 현재 Sleep 모드인지 확인
                    // 2. [현재 Sleep] 동작 없음.
                    // 3. Timer 종료 이벤트 요청
                    // 4. Timer는 이전 실행 중이던 모드 정보와 카운트 정보, 종료 날짜/시간 정보를 저장한 후 리셋
                    // 5. Timer에 Sleep 모드로 실행.
                    // 6. Timer는 클릭한 날짜/시간 정보와 Sleep 모드를 저장.
                record(status: "sleep")
            }) {
                Text("잠")
            }
            
            Button(action: {
                print("클릭")
                // wake 모드의 open eyes
                    // Click Event
                    // 1. 현재 Wake.OpenEyes 모드인지 확인.
                    // 2. [--] 동작 없음.
                    // 3. Timer 종료 이벤트 요청
                    // 4. Timer는 이전 실행 중이던 정보와 카운트 정보, 종료 날짜/시간 정보를 저장한 후 리셋
                    // 5. Timer에 Wake.OpenEyes 모드로 실행.
                    // 6. Timer는 클릭한 날짜/시간 정보와 Wake.OpenEyes 모드를 저장
                record(status: "wake_openEyes")
            }) {
                Text("눈뜸")
            }
            
            Button(action: {
                print("클릭")
                // wake 모드의 crying
                    // Click Event Wake.OpenEyes와 동일
                record(status: "wake_crying")
            }) {
                Text("움")
            }
            
            Button(action: {
                print("클릭")
                // wake 모드의 whine
                    // Click Event Wake.OpenEyes와 동일
                record(status: "wake_whine")
            }) {
                Text("칭얼")
            }
            
            Button(action: {
                print("클릭")
                // skill 이벤트의 encourage
                    // Click Event
                    // 1. 현재 날짜/시간 정보가 입력된 모달 창 Open
                    // 2. 시간 수정이 필요한 경우 수정
                    // 3. 모달 창의 '등록' 버튼 누를 시 이벤트 발생
                    // 4. 등록 이벤트 시 입력한 날짜/시간 정보와 Skill.Encourage 등록
                
            }) {
                Text("격려")
            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
