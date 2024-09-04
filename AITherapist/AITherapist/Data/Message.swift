//
//  Message.swift
//  AITherapist
//
//  Created by Shirin-Yan on 15.08.2024.
//

import Foundation

struct Message: Codable, Identifiable {
    var id: String
    var threadId: Int
    var isSenderMe: Bool
    var text: String
    var datetime: String
    
    init(id: String, threadId: Int, isSenderMe: Bool, text: String, datetime: String) {
        self.id = id
        self.threadId = threadId
        self.isSenderMe = isSenderMe
        self.text = text
        self.datetime = datetime
    }
    
    init(_ data: [String: Any]){
        id = data["id"] as? String ?? ""
        threadId = data["threadId"] as? Int ?? 0
        isSenderMe = data["isSenderMe"] as? Bool ?? true
        text = data["text"] as? String ?? ""
        datetime = data["datetime"] as? String ?? ""
    }
}
