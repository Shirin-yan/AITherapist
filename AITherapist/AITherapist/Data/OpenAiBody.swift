//
//  OpenAiBody.swift
//  AITherapist
//
//  Created by Shirin-Yan on 04.09.2024.
//

import Foundation

struct OpenAiBody: Codable {
    var model = OPENAI_MODEL
    var maxTokens: Int = 400
    var messages: [OpenAiMessage] = []
    
    enum CodingKeys: String, CodingKey {
        case model
        case maxTokens = "max_tokens"
        case messages
    }
}
