//
//  OpenAiResponse.swift
//  AITherapist
//
//  Created by Shirin-Yan on 04.09.2024.
//

import Foundation

struct OpenAIResponse: Codable {
    let id: String
    let model: String
    let choices: [Choice]
}

struct Choice: Codable {
    let finishReason: String
    let message: OpenAiMessage

    enum CodingKeys: String, CodingKey {
        case finishReason = "finish_reason"
        case message
    }
}

