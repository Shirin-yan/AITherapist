//
//  Resolver.swift
//  AITherapist
//
//  Created by Shirin-Yan on 05.09.2024.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { ChatRepo() }
    }
}
