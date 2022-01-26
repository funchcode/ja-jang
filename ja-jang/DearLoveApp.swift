//
//  ja_jangApp.swift
//  ja-jang
//
//  Created by funch on 2022/01/18.
//

import SwiftUI

@main
struct DearLoveApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
            WindowGroup {
                ContentView()
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
