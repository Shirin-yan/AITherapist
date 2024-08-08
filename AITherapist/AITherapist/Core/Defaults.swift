//
//  Defaults.swift
//  AITherapist
//
//  Created by Shirin-Yan on 08.08.2024.
//

import Foundation

enum DefaultsKey: String {
    case onboardingShown
    case token
}

class Defaults {
    static var onboardingShown: Bool {
        get { UserDefaults.standard.bool(forKey: DefaultsKey.onboardingShown.rawValue) }
        set { UserDefaults.standard.setValue(newValue, forKey: DefaultsKey.onboardingShown.rawValue)}
    }

    static var token: String {
        get { UserDefaults.standard.string(forKey: DefaultsKey.token.rawValue) ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: DefaultsKey.token.rawValue)}
    }
}
