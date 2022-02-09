//
//  ja_jangApp.swift
//  ja-jang
//
//  Created by funch on 2022/01/18.
//

import SwiftUI
import Firebase

@main
struct DearLoveApp: App {
    @Environment(\.scenePhase) var scenePhase
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
            WindowGroup {
                HomeView()
//                RecordView()
            }.onChange(of: scenePhase) { phase in
                switch phase {
                case .background:
                    print("App is in background")
                case .active:
                    print("App is Active")
                case .inactive:
                    print("App is Inactive")
                @unknown default:
                    print("New App state not yet introduced")
                }
            }
        }
}
