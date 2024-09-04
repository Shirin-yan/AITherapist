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
}
