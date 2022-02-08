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
    
    func getHistory(descending: Bool, limit: Int) -> Any {
        usersRef.document(userId).collection("history").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("파이어스토어에서 데이터를 조회하는 도중 에러가 발생했습니다.")
                print(err)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
