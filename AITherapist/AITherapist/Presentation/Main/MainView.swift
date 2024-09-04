//
//  MainView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 04.09.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm = MainVM()
    @State var selectedTab = 0

    
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        appearance.selectionIndicatorTintColor = UIColor.blue
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        ZStack {
            if vm.inProgress {
                ZStack {
                    Color.black.opacity(0.1).ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            } else {
                TabView(selection: $selectedTab) {
                    ChatlistView()
                        .tabItem{ Label("Home", systemImage: "house") }
                        .tag(0)
                    
                    FavoriteListView()
                        .tabItem{ Label("Favorites", systemImage: "heart") }
                        .tag(1)
                    
                    SettingsView()
                        .tabItem{ Label("Settings", systemImage: "gear") }
                        .tag(2)
                }
            }
        }
    }
}

#Preview {
    MainView()
}
