//
//  LoginVM.swift
//  AITherapist
//
//  Created by Shirin-Yan on 07.08.2024.
//

import Foundation
import GoogleSignIn
import AuthenticationServices

class LoginVM: ObservableObject {
    @Published var inProgress = false
    @Published var error = false
    @Published var errorString = ""
    
    var appleSignInDelegate: AppleSignInDelegate?

    init() {
        self.appleSignInDelegate = AppleSignInDelegate(vm: self)
    }

    func signInGoogle(){
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { signInResult, error in
            guard error == nil else { return }
            
            guard let signInResult = signInResult else { return }
            let user = signInResult.user
            
            let id = user.userID ?? UUID().uuidString
            let name = user.profile?.name ?? ""
            let email = user.profile?.email ?? ""

        }
    }
    
    func signInApple() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = appleSignInDelegate
        controller.performRequests()
    }

    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }

        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
