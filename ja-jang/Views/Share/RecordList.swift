//
//  RecordList.swift
//  ja-jang
//
//  Created by funch on 2022/02/24.
//

import SwiftUI

class RecordBundler {
    
    static func bundle(records: [BabyStatuss]) -> [BundleRecords] {
        var dateSet = Set<String>()
        var prevDate: String = ""
        var bundleRecords: [BundleRecords] = []
        var recordList: [BabyStatuss] = []
        for record in records {
            let startedDate = String(record.startedDate.split(separator: " ")[0])
            if (dateSet.isEmpty) {
                dateSet.insert(startedDate)
                prevDate = startedDate
            }
            if (dateSet.contains(startedDate)) {
                recordList.append(record)
            } else {
                bundleRecords.append(BundleRecords(
                    date: prevDate,
                    records: recordList
                ))
                dateSet.insert(startedDate)
                recordList.removeAll()
                recordList.append(record)
                prevDate = startedDate
            }
        }
        return bundleRecords
    }
}

struct BundleRecords: Hashable, Identifiable {
    let id = UUID()
    let date: String
    let records: [BabyStatuss]
}

struct BabyStatuss: Hashable, Identifiable {
    let id = UUID()
    let type: String
    let status: String
    let startedDate: String
    let finishedDate: String
}
var babyRecord2: [BabyStatuss] = [
    BabyStatuss(
        type: "status",
        status: "sleep",
        startedDate: "2022-02-24 22:25:02",
        finishedDate: "2022-02-24 22:30:14"
    ),
    BabyStatuss(
        type: "status",
        status: "sleep",
        startedDate: "2022-02-24 22:25:02",
        finishedDate: "2022-02-24 22:30:14"
    ),
    BabyStatuss(
        type: "status",
        status: "sleep",
        startedDate: "2022-02-24 22:25:02",
        finishedDate: "2022-02-24 22:30:14"
    ),
    BabyStatuss(
        type: "status",
        status: "sleep",
        startedDate: "2022-02-24 22:25:02",
        finishedDate: "2022-02-24 22:30:14"
    ),
    BabyStatuss(
        type: "status",
        status: "sleep",
        startedDate: "2022-02-24 22:25:02",
        finishedDate: "2022-02-24 22:30:14"
    ),
    BabyStatuss(
        type: "status",
        status: "sleep",
        startedDate: "2022-02-24 22:25:02",
        finishedDate: "2022-02-24 22:30:14"
    ),
    BabyStatuss(
        type: "status",
        status: "sleep",
        startedDate: "2022-02-24 22:25:02",
        finishedDate: "2022-02-24 22:30:14"
    ),
    BabyStatuss(
        type: "status",
        status: "sleep",
        startedDate: "2022-02-24 22:25:02",
        finishedDate: "2022-02-24 22:30:14"
    ),
    BabyStatuss(
        type: "status",
        status: "sleep",
        startedDate: "2022-02-24 22:25:02",
        finishedDate: "2022-02-24 22:30:14"
    ),
    BabyStatuss(
        type: "status",
        status: "sleep",
        startedDate: "2022-02-24 22:25:02",
        finishedDate: "2022-02-24 22:30:14"
    ),
    BabyStatuss(
        type: "status",
        status: "sleep",
        startedDate: "2022-02-24 22:25:02",
        finishedDate: "2022-02-24 22:30:14"
    )
]
struct RecordList: View {
    init() {
        UITableView.appearance().sectionHeaderTopPadding = 0
        UITableView.appearance().sectionHeaderHeight = 100
        UITableView.appearance().sectionFooterHeight = 0
    }
    var babyRecords: [BundleRecords] = [
        BundleRecords(
            date: "2022.02.12",
            records: [
                BabyStatuss(
                    type: "status",
                    status: "sleep",
                    startedDate: "2022-02-24 22:25:02",
                    finishedDate: "2022-02-24 22:30:14"
                ),
                BabyStatuss(
                    type: "status",
                    status: "sleep",
                    startedDate: "2022-02-24 22:25:02",
                    finishedDate: "2022-02-24 22:30:14"
                ),
                BabyStatuss(
                    type: "status",
                    status: "sleep",
                    startedDate: "2022-02-24 22:25:02",
                    finishedDate: "2022-02-24 22:30:14"
                ),
                BabyStatuss(
                    type: "status",
                    status: "sleep",
                    startedDate: "2022-02-24 22:25:02",
                    finishedDate: "2022-02-24 22:30:14"
                )
            ]
        ),
        BundleRecords(
            date: "2022.02.13",
            records: [
                BabyStatuss(
                    type: "status",
                    status: "sleep",
                    startedDate: "2022-02-24 22:25:02",
                    finishedDate: "2022-02-24 22:30:14"
                ),
                BabyStatuss(
                    type: "status",
                    status: "sleep",
                    startedDate: "2022-02-24 22:25:02",
                    finishedDate: "2022-02-24 22:30:14"
                ),
                BabyStatuss(
                    type: "status",
                    status: "sleep",
                    startedDate: "2022-02-24 22:25:02",
                    finishedDate: "2022-02-24 22:30:14"
                ),
                BabyStatuss(
                    type: "status",
                    status: "sleep",
                    startedDate: "2022-02-24 22:25:02",
                    finishedDate: "2022-02-24 22:30:14"
                )
            ]
        )
    ]
    
    @State private var singleSelection : UUID?
    
    var body: some View {
        List(selection: $singleSelection) {
            ForEach(babyRecords, id: \.self) { recordSet in
                Section(header: Text("\(recordSet.date)")) {
                    ForEach(recordSet.records) { record in
                        NavigationLink(destination: EditView()){
                            Text(record.status)
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct RecordList_Previews: PreviewProvider {
    static var previews: some View {
        RecordList()
    }
}
