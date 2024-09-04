//
//  Tag.swift
//  AITherapist
//
//  Created by Shirin-Yan on 15.08.2024.
//

import Foundation

struct Tag: Codable {
    var id: Int
    var name: String
    
    init(_ data: [String: Any]){
        self.id = data["id"] as? Int ?? 0
        self.name = data["name"] as? String ?? ""
    }
}
