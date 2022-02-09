//
//  ContentView.swift
//  ja-jang
//
//  Created by funch on 2022/01/18.
//

import SwiftUI
import Firebase

struct HomeView: View {
    var body: some View {
        TabView {
            NavigationView {
                RecordView().navigationTitle("기록")
            }
            .tabItem {
                Image("moon")
                Text("기록")
            }
            
            NavigationView {
                Button(action: {
                    print("클릭")
                }) {
                    Text("쪽쪽이")
                }
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
