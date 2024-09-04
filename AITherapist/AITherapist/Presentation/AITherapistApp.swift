//
//  AITherapistApp.swift
//  AITherapist
//
//  Created by Shirin-Yan on 03.08.2024.
//

import SwiftUI
import Firebase

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
                NavigationView {
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
    return true
  }
}
