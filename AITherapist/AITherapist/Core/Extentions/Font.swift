//
//  Font.swift
//  AITherapist
//
//  Created by Shirin-Yan on 06.08.2024.
//

import SwiftUI

extension Font {
    
    public enum AppFontWeight: String {
        case regular = "Inter-Regular"
        case medium = "Inter-Medium"
        case semibold = "Inter-SemiBold"
        case bold = "Inter-Bold"
    }
    
    static public func inter(_ size: CGFloat, fontWeight: AppFontWeight) -> Font {
        return Font.custom(fontWeight.rawValue, size: size)
    }
}
