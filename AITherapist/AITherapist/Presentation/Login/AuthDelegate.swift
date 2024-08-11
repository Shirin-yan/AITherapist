//
//  AuthDelegate.swift
//  AITherapist
//
//  Created by Shirin-Yan on 11.08.2024.
//

import UIKit
import AuthenticationServices

class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate {
    weak var vm: LoginVM?

    init(vm: LoginVM){
        self.vm = vm
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization){
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let id = appleIdCredential.user
            let name = [(appleIdCredential.fullName?.givenName ?? ""), (appleIdCredential.fullName?.familyName ?? "")].joined(separator: " ")
            let email = appleIdCredential.email ?? ""

        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        vm?.inProgress = false
        vm?.error = true
        vm?.errorString = error.localizedDescription
    }
}
