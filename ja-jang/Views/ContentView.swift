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
            NavigationView{
                Text("")
                    .navigationBarTitle("기록")
            }
            .tabItem {
                Text("기록")
                Image(systemName: "1.square.fill")
            }.tag(1)

            NavigationView{
                Text("")
                    .navigationTitle("통계")
            }
            .tabItem {
                Text("통계")
                Image(systemName: "2.square.fill")
            }.tag(2)

            NavigationView{
                Text("")
                    .navigationTitle("통계")
            }
            .tabItem {
                Text("설정")
                Image(systemName: "3.square.fill")
            }.tag(3)
        }
        .font(.headline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
