//
//  Encodable.swift
//  AITherapist
//
//  Created by Shirin-Yan on 16.08.2024.
//

import Foundation

extension Encodable {
    var getDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)).flatMap { $0 as? [String: Any] }
    }
}
