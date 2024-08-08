//
//  AITherapistApp.swift
//  AITherapist
//
//  Created by Shirin-Yan on 03.08.2024.
//

import SwiftUI

@main
struct AITherapistApp: App {
    @AppStorage(DefaultsKey.onboardingShown.rawValue) var onboardingShown = Defaults.onboardingShown
    @AppStorage(DefaultsKey.token.rawValue) var token = Defaults.token
    
    var body: some Scene {
        WindowGroup {
            if !onboardingShown {
                OnboardingView()
            } else if
                token.isEmpty {
                LoginView()
            } else {
                NavigationView {
                    ChatlistView()
                }.navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}
