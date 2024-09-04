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
    var messages: [Message]
    
    init(id: String, name: String, email: String, messages: [Message]) {
        self.id = id
        self.name = name
        self.email = email
        self.messages = messages
    }
    
    init(_ data: [String: Any]){
        self.id = data["id"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.messages = [] //data["messages"] as? String ?? ""
    }

    func dictToSave() -> [String: String] {
        return [
            "id": id,
            "name": name,
            "email": email
        ]
    }
}
