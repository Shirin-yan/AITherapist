//
//  Subscription.swift
//  AITherapist
//
//  Created by Shirin-Yan on 12.09.2024.
//

import Foundation

struct Subscription: Codable {
    var id: String
    var messageCount: Int
    
    init(id: String, messageCount: Int) {
        self.id = id
        self.messageCount = messageCount
    }
    
    init(_ data: [String: Any]){
        self.id = data["id"] as? String ?? ""
        self.messageCount = data["message_count"] as? Int ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case messageCount = "message_count"
    }
}

struct UserSubscription: Codable {
    var id: String
    var messageCount: Int
    var subscriptionEnds: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case messageCount = "message_count"
        case subscriptionEnds = "subscription_ends"
    }
    
    init(id: String, messageCount: Int, subscriptionEnds: String) {
        self.id = id
        self.messageCount = messageCount
        self.subscriptionEnds = subscriptionEnds
    }
    
    init(_ data: [String: Any]){
        self.id = data["id"] as? String ?? ""
        self.messageCount = data["message_count"] as? Int ?? 0
        self.subscriptionEnds = data["subscription_ends"] as? String ?? ""
    }
}
