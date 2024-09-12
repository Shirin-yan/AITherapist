//
//  View.swift
//  AITherapist
//
//  Created by Shirin-Yan on 12.09.2024.
//

import SwiftUI
import Adapty
import AdaptyUI

struct SafePaywallModifier: ViewModifier {
    @Binding var isPresented: Bool
    let paywall: AdaptyPaywall?
    let viewConfiguration: AdaptyUI.LocalizedViewConfiguration?
    let didPerformAction: ((AdaptyUI.Action) -> Void)?
    let didFinishPurchase: ((AdaptyPaywallProduct, AdaptyPurchasedInfo) -> Void)?
    let didFailPurchase: (AdaptyPaywallProduct, AdaptyError) -> Void
    let didFinishRestore: (AdaptyProfile) -> Void
    let didFailRestore: (AdaptyError) -> Void
    let didFailRendering: (AdaptyError) -> Void

    func body(content: Content) -> some View {
        Group {
            if let paywall = paywall, let viewConfiguration = viewConfiguration {
                content.paywall(
                    isPresented: $isPresented,
                    paywall: paywall,
                    viewConfiguration: viewConfiguration,
                    didPerformAction: didPerformAction,
                    didFinishPurchase: didFinishPurchase,
                    didFailPurchase: didFailPurchase,
                    didFinishRestore: didFinishRestore,
                    didFailRestore: didFailRestore,
                    didFailRendering: didFailRendering
                )
            } else {
                content
            }
        }
    }
}

extension View {
    func safePaywall(
        isPresented: Binding<Bool>,
        paywall: AdaptyPaywall?,
        viewConfiguration: AdaptyUI.LocalizedViewConfiguration?,
        didPerformAction: ((AdaptyUI.Action) -> Void)? = nil,
        didFinishPurchase: ((AdaptyPaywallProduct, AdaptyPurchasedInfo) -> Void)? = nil,
        didFailPurchase: @escaping (AdaptyPaywallProduct, AdaptyError) -> Void,
        didFinishRestore: @escaping (AdaptyProfile) -> Void,
        didFailRestore: @escaping (AdaptyError) -> Void,
        didFailRendering: @escaping (AdaptyError) -> Void
    ) -> some View {
        self.modifier(SafePaywallModifier(
            isPresented: isPresented,
            paywall: paywall,
            viewConfiguration: viewConfiguration,
            didPerformAction: didPerformAction,
            didFinishPurchase: didFinishPurchase,
            didFailPurchase: didFailPurchase,
            didFinishRestore: didFinishRestore,
            didFailRestore: didFailRestore,
            didFailRendering: didFailRendering
        ))
    }
}
