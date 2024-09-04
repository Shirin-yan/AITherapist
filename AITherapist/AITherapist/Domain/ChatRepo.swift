//
//  ChatRepo.swift
//  AITherapist
//
//  Created by Shirin-Yan on 11.08.2024.
//

import Foundation
import Alamofire

class ChatRepo {
    func getAnswer(messages: [OpenAiMessage], completion: @escaping (Result<OpenAiResponse, AFError>)->()) {
        Network.perform(endpoint: Endpoints.openAiCompletion(messages), completionHandler: completion)
    }
}
