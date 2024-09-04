//
//  ChatVM.swift
//  AITherapist
//
//  Created by Shirin-Yan on 08.08.2024.
//

import Foundation
import Resolver

class ChatVM: ObservableObject {
    
    @Injected var repo: ChatRepo

    var threadId: Int
    var openAiBodyMessage: [OpenAiMessage] = []
    
    @Published var data: [Message] = []
    @Published var inProgress = false

    init(threadId: Int) {
        self.threadId = threadId
        
    }
    
    func sendMsg(data: String){
        let msgToInsert = Message(id: UUID().uuidString, threadId: threadId, isSenderMe: true, text: data, datetime: Date().ISO8601Format())
        self.saveMsgToFirebase(msg: msgToInsert)
        openAiBodyMessage.append(OpenAiMessage(role: "user", content: data))
        getResponse()
    }
    
    func getResponse(){
        inProgress = true
        repo.getAnswer(messages: openAiBodyMessage.suffix(9)) { [weak self] res in
            self?.inProgress = false
            switch res {
            case .success(let success):
                let msgToInsert = Message(id: success.id, threadId: self?.threadId ?? 0, isSenderMe: false, text: success.choices.first?.message.content ?? "", datetime: Date().ISO8601Format())
                self?.saveMsgToFirebase(msg: msgToInsert)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func saveMsgToFirebase(msg: Message){
        self.data.insert(msg, at: 0)
    }
}
