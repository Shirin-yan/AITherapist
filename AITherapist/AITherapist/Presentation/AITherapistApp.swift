//
//  AITherapistApp.swift
//  AITherapist
//
//  Created by Shirin-Yan on 03.08.2024.
//

import SwiftUI
import Firebase
import Adapty
import AdaptyUI

@main
struct AITherapistApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
                NavigationStack {
                    MainView()
                }.navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        FirestoreManager.shared.getSubscriptions()
        let configurationBuilder = Adapty.Configuration
            .Builder(withAPIKey: ADAPTY_ID)
            .with(observerMode: false)
            .with(idfaCollectionDisabled: false)
            .with(ipAddressCollectionDisabled: false)
        
        Adapty.activate(with: configurationBuilder)
        AdaptyUI.activate()

        return true
    }
}
