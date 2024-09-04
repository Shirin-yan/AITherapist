//
//  ChatVM.swift
//  AITherapist
//
//  Created by Shirin-Yan on 08.08.2024.
//

import Foundation

class ChatVM: ObservableObject {
    
    @Published var data: [Message] = []
    
    
    func sendMsg(data: String){
        let msgToInsert = Message(threadId: "", isSenderMe: true, text: data, datetime: Date().ISO8601Format())
        self.data.insert(msgToInsert, at: 0)
        print(msgToInsert)
    }
}
