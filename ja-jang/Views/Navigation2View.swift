//
//  NavigationView.swift
//  ja-jang
//
//  Created by funch on 2022/01/26.
//

import SwiftUI

struct Navigation2View: View {
    let items = ["Chocolate", "Vanilla", "Strawberry", "Mint Chip",
                     "Pistachio"]
    var body: some View {
        TabView {
            RecordView()
                .badge(10)
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("기록")
                }
            Text("Another Tab")
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("통계")
                }
            Text("The Last Tab")
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("정보")
                }
        }
        .font(.headline)
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        Navigation2View()
    }
}
