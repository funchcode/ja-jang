//
//  RecordViews.swift
//  ja-jang
//
//  Created by funch on 2022/02/24.
//

import SwiftUI

struct RecordViews: View {
    var body: some View {
        TabView {
            RecordView()
                .background(Color("DefaultColor"))
                .tabItem {
                    Image("love")
                    Text("기록")
                        .foregroundColor(Color("SignatureColor"))
                }
        }
        .accentColor(Color("SignatureColor"))
        .font(.headline)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor(Color("DeepDark").opacity(1))
            UITabBar.appearance().standardAppearance = appearance
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

struct RecordViews_Previews: PreviewProvider {
    static var previews: some View {
        RecordViews()
    }
}
