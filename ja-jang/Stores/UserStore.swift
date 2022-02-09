//
//  UserStore.swift.swift
//  ja-jang
//
//  Created by funch on 2022/02/08.
//

import Foundation

class UserStore: ObservableObject {
    let userId: String
    let usersRef = db.collection("users")
    @Published var histories: [HistoryModel] = []
    
    init(userId: String) {
        self.userId = userId
    }
    
    func addHistory(type: String, status: String, startedAt: String, finishedAt: String?) {
        usersRef.document(userId).collection("history").addDocument(data: [
            "type": type,
            "status": status,
            "startedAt": startedAt,
            "finishedAt": finishedAt != nil ? finishedAt! : ""
        ]) { err in
            if err != nil {
                print("addHistory() 에러")
                print(err!)
            }
        }
    }
    
    func getHistory(descending: Bool, limit: Int) {
        usersRef.document(userId).collection("history").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("파이어스토어에서 데이터를 조회하는 도중 에러가 발생했습니다.")
                print(err)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let data = document.data()
                    let type = data["type"] as? String ?? ""
                    let status = data["status"] as? String ?? ""
                    let startedAt = data["startedAt"] as? String ?? ""
                    let finishedAt = data["finishedAt"] as? String ?? ""
                    self.histories.append(HistoryModel(type: type, stauts: status, finishedAt: finishedAt, startedAt: startedAt))
                }
            }
        }
    }
}
