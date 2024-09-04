//
//  MainVM.swift
//  AITherapist
//
//  Created by Shirin-Yan on 04.09.2024.
//

import Foundation

class MainVM: ObservableObject {
    
    @Published var inProgress = false
    
    init() {
        inProgress = true
        FirestoreManager.shared.getUser(id: Defaults.token) 
        FirestoreManager.shared.getTags { tags in
            FirestoreManager.shared.getTherapists { therapists in
                self.inProgress = false
            }
        }
    }
}
