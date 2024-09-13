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

enum SubscriptionPeriod: String {
    case weekly, monthly, yearly
}

class SubscriptionService: ObservableObject {
    var paywall: AdaptyPaywall? = nil
    var paywallError: Error? = nil
    var configuration: AdaptyUI.LocalizedViewConfiguration? = nil
    var toShowAfterFinish = false
    var isUserPremium: Bool = false

    @Published var showPaywall = false
    
    var profile: AdaptyProfile? = nil {
        didSet {
            let premium = self.isPremium()
            self.isUserPremium = premium
        }
    }

    
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
    
    func getActiveProduct() -> AdaptyProfile.AccessLevel? {
        return profile?.accessLevels.first(where: {$0.value.isActive})?.value
    }
    
    func getExpireDate() -> Date? {
        guard let active = getActiveProduct() else { return nil }
        return active.expiresAt
    }
    
    func getActivatedDate() -> Date? {
        guard let active = getActiveProduct() else { return nil }
        return active.activatedAt
    }
    
    func getSubscriptionPeriod() -> SubscriptionPeriod? {
        guard let active = getActiveProduct() else { return nil}
        return SubscriptionPeriod(rawValue: active.vendorProductId.components(separatedBy: ".").last ?? "")
    }
    
    func calculateRenewalCounts(from: String) -> Int {
        
        guard isUserPremium,
              !from.isEmpty,
              let subscription = getSubscriptionPeriod(),
              let lastActivatedDate = getActivatedDate() else { return 0 }
                
        let lastSubsEndTime = from.getDate()
        if lastActivatedDate == lastSubsEndTime { return 0 }
        
        let calendar = Calendar.current
        var renewalCount = 0
        switch subscription {
        case .weekly:
            renewalCount = calendar.dateComponents([.weekOfYear], from: lastSubsEndTime, to: lastActivatedDate).weekOfYear ?? 0
        case .monthly:
            renewalCount = calendar.dateComponents([.month], from: lastSubsEndTime, to: lastActivatedDate).month ?? 0
        case .yearly:
            renewalCount = calendar.dateComponents([.year], from: lastSubsEndTime, to: lastActivatedDate).year ?? 0
        default:
            return 0
        }
        
        return renewalCount < 0 ? 0 : renewalCount
    }
}
