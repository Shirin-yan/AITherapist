//
//  ChatlistVM.swift
//  AITherapist
//
//  Created by Shirin-Yan on 08.08.2024.
//

import Foundation

class ChatlistVM: ObservableObject {

    @Published var tags: [Tag] = FirestoreManager.shared.tags
    @Published var data: [Therapist] = FirestoreManager.shared.therapists
    
    @Published var showPurchase = false

    init(){
        showPurchase.toggle()
    }
}
