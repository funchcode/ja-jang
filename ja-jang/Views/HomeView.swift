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
                ZStack {
                    RecordView()
                        .navigationTitle("기록")
                        .background(Color("DefaultColor"))
                }
            }
            .tabItem {
                Image("love")
                Text("기록")
                    .foregroundColor(Color("SignatureColor"))
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
        .accentColor(Color("SignatureColor"))
        .font(.headline)
        .onAppear {
            let appearance = UITabBarAppearance()
//                    appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            
            appearance.backgroundColor = UIColor(Color("DeepDark").opacity(1))
                    
                    // Use this appearance when scrolling behind the TabView:
                    UITabBar.appearance().standardAppearance = appearance
                    // Use this appearance when scrolled all the way up:
                    UITabBar.appearance().scrollEdgeAppearance = appearance
            
            let coloredAppearance = UINavigationBarAppearance()
                    coloredAppearance.configureWithTransparentBackground()
                    coloredAppearance.backgroundColor = UIColor(Color("DeepDark").opacity(1))
                    coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color("SignatureColor").opacity(1))]
                    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color("SignatureColor").opacity(1))]
            UINavigationBar.appearance().standardAppearance = coloredAppearance
                    UINavigationBar.appearance().compactAppearance = coloredAppearance
                    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
                }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
