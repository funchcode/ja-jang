//
//  RecordList.swift.swift
//  ja-jang
//
//  Created by funch on 2022/02/20.
//

import SwiftUI

struct RecordList: View {
    @ObservedObject var userStore: UserStore = UserStore(userId: "hansol")
    
//    init() {
//        userStore.getHistory(descending: false, limit: 10)
//    }
    
    var body: some View {
        ScrollView {
              Text("04:07")
//            ForEach(userStore.self.histories, id: \.self) { history in
//                HStack {
//                    // 시간
//                    Text("04:07")
//
//                    // 상태
//                    Text(history.stauts)
//                }
//                .frame(
//                    minWidth: 0,
//                    maxWidth: .infinity,
//                    minHeight: 0,
//                    maxHeight: .infinity
//                )
//            }
        }
    }
}

struct RecordList_swift_Previews: PreviewProvider {
    static var previews: some View {
        RecordList()
    }
}
