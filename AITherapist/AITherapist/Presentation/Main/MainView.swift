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
                }.onAppear {
                    subscriptionService.toShowAfterFinish = true
                    subscriptionService.getPaywall()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
                        let currentSub = FirestoreManager.shared.user?.subscription
                        let msgCount = FirestoreManager.shared.subscriptions.first(where: { $0.id == currentSub?.id })?.messageCount ?? 10
                        let subEndDate = currentSub?.subscriptionEnds ?? ""
                        
                        let renewals = subscriptionService.calculateRenewalCounts(from: subEndDate)
                        let expire = "2024-09-13T18:08:06Z"//subscriptionService.getExpireDate()?.ISO8601Format() ?? subEndDate
                        FirestoreManager.shared.user?.subscription?.subscriptionEnds = expire
                        FirestoreManager.shared.user?.leftMessage += renewals*msgCount
                        FirestoreManager.shared.updateUser()
                    }
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
                    break
                }
            },
            didFinishPurchase: { product, profile in
                subscriptionService.showPaywall = false
                let msgCount = FirestoreManager.shared.subscriptions.first(where: { $0.id == product.vendorProductId })?.messageCount ?? 10
                let expireDate = profile.profile.accessLevels.first(where: {$0.value.isActive})?.value.expiresAt?.ISO8601Format() ?? ""
                FirestoreManager.shared.user?.subscription = UserSubscription(id: product.vendorProductId, messageCount: msgCount, subscriptionEnds: expireDate)
                FirestoreManager.shared.user?.leftMessage += msgCount
                FirestoreManager.shared.updateUser()
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
        
    }
    
}

#Preview {
    MainView()
}
