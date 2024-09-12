//
//  SubscriptionService.swift
//  AITherapist
//
//  Created by Shirin-Yan on 12.09.2024.
//

import Foundation
import Adapty
import AdaptyUI
import SwiftUI

class SubscriptionService: ObservableObject {
    var paywall: AdaptyPaywall? = nil
    var paywallError: Error? = nil
    var configuration: AdaptyUI.LocalizedViewConfiguration? = nil
    var toShowAfterFinish = false
    
    @Published var showPaywall = false
    
    var profile: AdaptyProfile? = nil {
        didSet {
            let premium = self.isPremium()
            self.isUserPremium = premium
        }
    }

    var isUserPremium: Bool = false
    
    func getPaywall() {
        Adapty.getPaywall(placementId: "onboarding", locale: "en") { result in
            switch result {
            case let .success(paywall):
                self.paywall = paywall
                self.getViewConfiguration()
            case let .failure(error):
                self.paywallError = error
            }
        }
    }
    
    func getViewConfiguration() {
        if let paywall = paywall {
            AdaptyUI.getViewConfiguration(forPaywall: paywall, loadTimeout: .defaultLoadPaywallTimeout) { result in
                switch result {
                case let .success(viewConfiguration):
                    self.configuration = viewConfiguration
                    Task {
                        await self.getUser()
                    }
                case let .failure(e):
                    print(e)
                }
            }
        }
    }

    func setUserId(_ userId: String) {
        Adapty.identify(userId)
    }

    func hidePaywallView() {
        self.showPaywall = false
    }
    
    func showPaywallView() {
        self.showPaywall = true
    }
    
    func getUser() async {
        guard let profile = try? await Adapty.getProfile() else {
            return
        }
        self.setProfile(profile)
    }
    
    func setProfile(_ profile: AdaptyProfile) {
        self.profile = profile
        DispatchQueue.main.async { [self] in
            if toShowAfterFinish {
                showPaywallView()
            }
        }
    }
    
    func isPremiumSync() async -> Bool {
        await getUser()
        return isPremium()
    }
    
    func isPremium() -> Bool {
        guard let profile = profile else {
            return false
        }
        
        return profile.accessLevels.contains { $0.value.isActive }
    }
    
    func restorePurchase() {
        Task {
            try? await Adapty.restorePurchases()
        }
    }
}
