//
//  Message.swift
//  AITherapist
//
//  Created by Shirin-Yan on 15.08.2024.
//

import Foundation

struct Message: Codable {
    var threadId: String
    var isSenderMe: Bool
    var text: String
    var datetime: String
}
