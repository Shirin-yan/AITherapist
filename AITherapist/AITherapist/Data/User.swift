//
//  User.swift
//  AITherapist
//
//  Created by Shirin-Yan on 15.08.2024.
//

import Foundation

struct User: Codable {
    var id: String
    var name: String
    var email: String
    var leftMessage: Int
    var subscription: UserSubscription?
    var free: UserSubscription?
    
    init(id: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
        self.subscription = nil
        self.free = nil
        self.leftMessage = 10
    }
    
    init(_ data: [String: Any]){
        self.id = data["id"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.subscription = UserSubscription(data["subscription"] as? [String: Any] ?? [:])
        self.free = UserSubscription(data["free"] as? [String: Any] ?? [:])
        self.leftMessage = data["left_message"] as? Int ?? 10
    }

    func dictToSave() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "email": email,
            "subscription": subscription?.getDictionary ?? [:],
            "free": free?.getDictionary ?? [:],
            "left_message": leftMessage
        ]
    }
}
