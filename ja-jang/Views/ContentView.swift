//
//  ContentView.swift
//  ja-jang
//
//  Created by funch on 2022/01/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                RecordView().navigationTitle("Record")
            }
            .tabItem {
                Image("moon")
                Text("기록")
            }
            
            NavigationView {
                Text("Book").navigationTitle("Book")
            }
            .tabItem {
                Image("book")
                Text("통계")
            }

            NavigationView {
                Text("Settings").navigationTitle("Settings")
            }
            .tabItem {
                Image("settings")
                Text("정보")
            }
        }
        .font(.headline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
