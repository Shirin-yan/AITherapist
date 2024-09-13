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
    var prompt: String
    var openAiBodyMessage: [OpenAiMessage] = []
    
    @Published var data: [Message] = []
    @Published var inProgress = false

    init(threadId: Int, prompt: String) {
        self.threadId = threadId
        self.prompt = prompt
        data = FirestoreManager.shared.getThreadMessage(threadId: threadId)
        openAiBodyMessage = data.map({OpenAiMessage(role: $0.isSenderMe ? "assistant" : "user", content: $0.text) })
    }
    
    func sendMsg(data: String){
        let msgToInsert = Message(id: UUID().uuidString, threadId: threadId, isSenderMe: true, text: data, datetime: Date().ISO8601Format())
        self.saveMsgToFirebase(msg: msgToInsert)
        openAiBodyMessage.append(OpenAiMessage(role: "user", content: data))
        getResponse()
    }
    
    func getResponse(){
        inProgress = true
        var body = Array(openAiBodyMessage.suffix(9))
        body.insert(OpenAiMessage(role: "system", content: prompt), at: 0)
        
        repo.getAnswer(messages: body) { [weak self] res in
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
        FirestoreManager.shared.saveMessage(msg: msg)
    }
}
