//
//  Font+.swift
//  ToDo
//
//  Created by Felipe Assis on 29/01/24.
//

import Foundation
import SwiftUI

extension Font {
    
    enum FontType: String {
        case lexend = "Lexend"
    }

    enum FontStyle: String {
        case bold = "-Bold"
        case medium = "-Medium"
        case regular = "-Regular"
        case semiBold = "-SemiBold"
        case light = "-Light"
    }
    
    static func customStyle(type: FontType, style: FontStyle, size: CGFloat, isScaled: Bool = true) -> Font {
        let fontName: String = type.rawValue + style.rawValue
        return Font.custom(fontName, size: size)
    }
}
