//
//  ChatVM.swift
//  AITherapist
//
//  Created by Shirin-Yan on 08.08.2024.
//

import Foundation

class ChatVM: ObservableObject {
    
    @Published var data: [String] = ["Hello I am Emily. I need your help", "Hello! I'm your therapist! I've been working in therapy since 1999  in a variety of settings including residential, shelters, and private practice. I am a Licensed Clinical Professional Counselor (LCPC) . I am a Nationally Certified Counselor (NCC) and is trained to provide EMDR treatment in addition to Cognitive Behavioral (CBT) therapies. So what did you want to discuss?"]
    
    
    func sendMsg(data: String){
        self.data.insert(data, at: 0)
    }
}
