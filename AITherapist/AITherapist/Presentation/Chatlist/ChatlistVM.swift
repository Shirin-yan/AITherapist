//
//  ChatlistVM.swift
//  AITherapist
//
//  Created by Shirin-Yan on 08.08.2024.
//

import Foundation

class ChatlistVM: ObservableObject {
    
    @Published var tags: [Tag] = []
    @Published var data: [Therapist] = []
    @Published var inProgress = false
    
    init() {
        inProgress = true
        FirestoreManager.shared.getTags { tags in
            self.tags = tags
            FirestoreManager.shared.getTherapists { therapists in
                self.data = therapists
                self.inProgress = false
            }
        }
    }
}
