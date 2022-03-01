//
//  ContentView.swift
//  ja-jang
//
//  Created by funch on 2022/01/18.
//

import SwiftUI
import Firebase

class VisibleRecordEditor: ObservableObject {
    @Published public var visible: Bool = false
}

struct HomeView: View {
    @State var showSheet: Bool = false
    @State var visibleEditor = VisibleRecordEditor()
    
    var body: some View {
        TabView {
            RecordView()
                .background(Color("DefaultColor"))
                .tabItem {
                    Image("love")
                    Text("기록")
                        .foregroundColor(Color("SignatureColor"))
                }
                .environmentObject(visibleEditor)
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
        
               UITableView.appearance().backgroundColor = UIColor(Color("DefaultColor"))
        }
        .fullScreenCover(isPresented: $visibleEditor.visible, content: {
            EditView()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
