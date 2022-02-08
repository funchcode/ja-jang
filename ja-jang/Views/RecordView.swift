//
//  RecordView.swift
//  ja-jang
//
//  Created by funch on 2022/01/19.
//

import SwiftUI
import Combine
import Firebase

var db = Firestore.firestore()
let user = db.collection("users")

enum BabyStatus: String {
    case sleep = "수면 중"
    case wakeOpenEyes = "눈 뜸"
    case wakeCrying = "움"
    case wakeWhine = "칭얼"
}

struct DBRecord {
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func save(startedAt: String) {
        user.document(id).collection("history").addDocument(data: [
            "type": "status",
            "status": "sleep",
            "startedAt": startedAt,
            "finishedAt" : "2022-02-07 23:24:00"
        ]) { err in
            print("PRINT: 에러!")
        }
    }

    func get() {
        user.document(id).collection("history").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("파이어스토어에서 데이터를 조회하는 도중 에러가 발생했습니다.")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func getSort() {
        user.document(id).collection("history").order(by: "startedAt", descending: true).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("파이어스토어에서 데이터를 조회하는 도중 에러가 발생했습니다.")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
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
    private var userRef = DBRecord.init(id: "hansol")
    
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
            userRef.get()
            userRef.save(startedAt: timestamp)
            secondTimer.reset()
            counter = 0
            print("save current status : " + status)
        case "wakeOpenEyes":
            print("current status : " + status)
            updateCurrentStatus(status: .wakeOpenEyes)
            currentRecord = CurrentRecord(startTime: Date.now, currentStatus: .wakeOpenEyes)
            userRef.getSort()
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
    
    var body: some View {
            VStack(alignment: .center) {
                Text(dateFormatter.string(from: currentRecord.startTime))
                HStack(alignment: .top) {
                    Text(currentRecord.currentStatus.rawValue)
                    Text(String(counter)).onReceive(secondTimer.getTimer!) { _ in
                        counter = Calendar.current.dateComponents([.second], from: currentRecord.startTime, to: Date.now).second!
                    }
                }

                Button(action: {
                    print(Calendar.current)
                    counter = 0
                        // Timer는 이전 실행 중이던 모드 정보와 카운트 정보, 종료 날짜/시간 정보를 저장한 후 리셋
                        // 6. Timer는 클릭한 날짜/시간 정보와 Sleep 모드를 저장.
                    record(status: "sleep")
                }) {
                    Text("잠")
                }

                Button(action: {
                    print("클릭")
                        // Timer는 이전 실행 중이던 정보와 카운트 정보, 종료 날짜/시간 정보를 저장한 후 리셋
                        // 6. Timer는 클릭한 날짜/시간 정보와 Wake.OpenEyes 모드를 저장
                    record(status: "wakeOpenEyes")
                }) {
                    Text("눈뜸")
                }

                Button(action: {
                    print("클릭")
                    // wake 모드의 crying
                        // Click Event Wake.OpenEyes와 동일
                    record(status: "wakeCrying")
                }) {
                    Text("움")
                }

                Button(action: {
                    print("클릭")
                    // wake 모드의 whine
                        // Click Event Wake.OpenEyes와 동일
                    record(status: "wakeWhine")
                }) {
                    Text("칭얼")
                }

                Button(action: {
                    print("클릭")
                        // 현재 날짜/시간 정보가 입력된 모달 창 Open
                        // 2. 시간 수정이 필요한 경우 수정
                        // 3. 모달 창의 '등록' 버튼 누를 시 이벤트 발생
                        // 4. 등록 이벤트 시 입력한 날짜/시간 정보와 Skill.Encourage 등록
                }) {
                    Text("격려")
                }

                Button(action: {
                    print("클릭")
                    // 현재 날짜/시간 정보가 입력된 모달 창 Open
                    // 2. 시간 수정이 필요한 경우 수정
                    // 3. 모달 창의 '등록' 버튼 누를 시 이벤트 발생
                    // 4. 등록 이벤트 시 입력한 날짜/시간 정보와 Skill.Encourage 등록
                }) {
                    Text("쪽쪽이")
                }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
