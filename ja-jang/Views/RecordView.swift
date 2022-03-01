//
//  RecordView.swift
//  ja-jang
//
//  Created by funch on 2022/01/19.
//

import SwiftUI
import Combine
import Firebase

enum BabyStatus: String {
    case sleep = "수면 중"
    case wakeOpenEyes = "눈 뜸"
    case wakeCrying = "움"
    case wakeWhine = "칭얼"
}

struct CurrentRecord {
    var startTime: Date
    var currentStatus: BabyStatus
    
    init(startTime: Date, currentStatus: BabyStatus) {
        self.startTime = startTime
        self.currentStatus = currentStatus
    }
}

struct SecondTimer {
    
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    
    init() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    }
    
    var getTimer: Publishers.Autoconnect<Timer.TimerPublisher>? {
        get {
            return timer
        }
    }
    
    mutating func reset() {
        stop()
        start()
    }
    
    mutating func start() {
        self.timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    }
    
    mutating func stop() {
        self.timer!.upstream.connect().cancel()
    }
}

struct RecordView: View {
    @State private var currentRecord: CurrentRecord = CurrentRecord(startTime: Date.now, currentStatus: .wakeOpenEyes)
    @State private var babyStatus: BabyStatus = .wakeOpenEyes
    @State private var counter: Int = 0
    @State private var secondTimer = SecondTimer.init()
    
    @ObservedObject var userStore: UserStore = UserStore(userId: "hansol")
    
    let screenSize = UIScreen.main.bounds
    
    init() {
        userStore.getHistory(descending: true, limit: 10)
    }
    
    private var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return df
    }()
    
    func updateCurrentStatus(status: BabyStatus) {
        babyStatus = status
    }
    
    func record(status: String) {
        let timestamp = timestamp()
        print(timestamp)
        
        if ("\(currentRecord.currentStatus)" == status) {
            print("same status" + status)
            return
        }
    
        switch status {
        case "sleep":
            print("current status : " + status)
            updateCurrentStatus(status: .sleep)
            currentRecord = CurrentRecord(startTime: Date.now, currentStatus: .sleep)
            userStore.addHistory(type: "none", status: "none", startedAt: "", finishedAt: "")
            secondTimer.reset()
            counter = 0
            print("save current status : " + status)
        case "wakeOpenEyes":
            print("current status : " + status)
            updateCurrentStatus(status: .wakeOpenEyes)
            currentRecord = CurrentRecord(startTime: Date.now, currentStatus: .wakeOpenEyes)
//            userStore.getHistory(descending: true, limit: 10)
            secondTimer.reset()
            counter = 0
            print("save current status : " + status)
        case "wakeCrying":
            print("current status : " + status)
            updateCurrentStatus(status: .wakeCrying)
            currentRecord = CurrentRecord(startTime: Date.now, currentStatus: .wakeCrying)
            secondTimer.reset()
            counter = 0
            print("save current status : " + status)
        case "wakeWhine":
            print("current status : " + status)
            updateCurrentStatus(status: .wakeWhine)
            currentRecord = CurrentRecord(startTime: Date.now, currentStatus: .wakeWhine)
            secondTimer.reset()
            counter = 0
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
    
    func displayTimestamp(date: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let string2Date = dateFormat.date(from: date)
        dateFormat.dateFormat = "yy/MM/dd HH시 mm분 ss초"
        let date2String = dateFormat.string(from: string2Date ?? Date())
        return date2String
    }
    
    var body: some View {
        VStack(alignment: .center) {
                Text(dateFormatter.string(from: currentRecord.startTime))
                HStack(alignment: .top) {
                    Text(currentRecord.currentStatus.rawValue)
                    Text(String(counter)).onReceive(secondTimer.getTimer!) { _ in
                        counter = Calendar.current.dateComponents([.second], from: currentRecord.startTime, to: Date.now).second!
                    }
                }
                HStack(alignment: .center) {
                    Button(action: {
                        print(Calendar.current)
                        counter = 0
                        record(status: "sleep")
                    }) {
                        VStack {
                            Image("sleep")
                            Text("잠")
                                .foregroundColor(Color("CloudColor"))
                        }
                    }
                    
                    Button(action: {
                        print("클릭")
                        record(status: "wakeOpenEyes")
                    }) {
                        VStack {
                            Image("wakeup")
                            Text("눈뜸")
                                .foregroundColor(Color("GroundColor"))
                        }
                    }
                    
                    Button(action: {
                        print("클릭")
                        record(status: "wakeCrying")
                    }) {
                        VStack {
                            Image("crying")
                            Text("움")
                                .foregroundColor(Color("GroundColor"))
                        }
                    }
                    
                    Button(action: {
                        print("클릭")
                        record(status: "wakeWhine")
                    }) {
                        VStack {
                            Image("wakeWhine")
                            Text("칭얼")
                                .foregroundColor(Color("GroundColor"))
                        }
                    }
                    
                    Button(action: {
                        print("클릭")
                    }) {
                        VStack {
                            Image("kiss")
                            Text("격려")
                                .foregroundColor(Color("SeaColor"))
                        }
                    }
                    
                    Button(action: {
                        print("클릭")
                        // 현재 날짜/시간 정보가 입력된 모달 창 Open
                        // 2. 시간 수정이 필요한 경우 수정
                        // 3. 모달 창의 '등록' 버튼 누를 시 이벤트 발생
                        // 4. 등록 이벤트 시 입력한 날짜/시간 정보와 Skill.Encourage 등록
                    }) {
                        VStack {
                            Image("bottle")
                            Text("쪽쪽이")
                                .foregroundColor(Color("SeaColor"))
                        }
                    }
                }
            RecordList()
                .frame(
                    width: screenSize.width,
                    height: screenSize.height
                )
            
        }
        .padding()
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .top
            )
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
