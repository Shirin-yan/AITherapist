//
//  MainView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 04.09.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var subscriptionService = SubscriptionService()
    
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
                    TherapistsView()
                        .tabItem{ Label("Therapists", systemImage: "list.dash") }
                        .tag(0)
                    FavoriteListView()
                        .tabItem{ Label("Favorites", systemImage: "heart") }
                        .tag(1)
                    
                    ChatlistView()
                        .tabItem{ Label("Chat", systemImage: "text.bubble.fill") }
                        .tag(2)
                    
                    SettingsView()
                        .tabItem{ Label("Settings", systemImage: "gear") }
                        .tag(3)
                }
            }
        }.safePaywall(
            isPresented: $subscriptionService.showPaywall,
            paywall: subscriptionService.paywall,
            viewConfiguration: subscriptionService.configuration,
            didPerformAction: { action in
                switch action {
                case .close:
                    subscriptionService.showPaywall = false
                default:
                    // Handle other actions
                    break
                }
            },
            didFinishPurchase: { product, profile in
                subscriptionService.showPaywall = false
            },
            didFailPurchase: { product, error in
                // Handle the error
            },
            didFinishRestore: { profile in
                // Check access level and dismiss
            },
            didFailRestore: { error in
                // Handle the error
            },
            didFailRendering: { error in
                subscriptionService.showPaywall = false
            }
        )
        .onAppear {
            subscriptionService.toShowAfterFinish = true
            subscriptionService.getPaywall()
        }
    }
    
}

#Preview {
    MainView()
}
