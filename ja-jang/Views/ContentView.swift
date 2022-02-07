//
//  ContentView.swift
//  ja-jang
//
//  Created by funch on 2022/01/18.
//

import SwiftUI
import Firebase

class Fire: ObservableObject {
    private var db = Firestore.firestore()
    func push() {
        db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            print(err)
        }
    }
}

struct ContentView: View {
    @ObservedObject private var fire = Fire()
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
//                Text("Book").navigationTitle("Book")
                Button(action: {
                    print("클릭")
                    fire.push()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
