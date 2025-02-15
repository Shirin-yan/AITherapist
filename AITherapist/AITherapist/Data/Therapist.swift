//
//  Therapist.swift
//  AITherapist
//
//  Created by Shirin-Yan on 15.08.2024.
//

import Foundation

struct Therapist: Identifiable {
    var id: Int
    var name: String
    var about: String
    var promt: String = ""
    var avatar: String = ""
    var tags: [Tag]
    
    init(_ data: [String: Any], tags: [Tag]){
        id = data["id"] as? Int ?? 0
        name = data["name"] as? String ?? ""
        about = data["about"] as? String ?? ""
        avatar = data["avatar"] as? String ?? ""
        promt = data["prompt"] as? String ?? ""
        self.tags = tags
    }
}
