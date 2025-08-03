//
//  Fonts+ext.swift
//  PhoenixUI
//
//  Created by Shahanul Haque on 3/6/25.
//
import SwiftUI

// MARK: Manrope Font Extension
extension Font {
    public enum ManropeFont {
        case regular
        case bold
        case extraBold
        case extraLight
        case light
        case medium
        case semiBold
        case custom(String)
        
        var value: String {
            switch self {
                case .regular:
                    return "Manrope-Regular"
                case .bold:
                    return "Manrope-Bold"
                case .extraBold:
                    return "Manrope-ExtraBold"
                case .extraLight:
                    return "Manrope-ExtraLight"
                case .light:
                    return "Manrope-Light"
                case .medium:
                    return "Manrope-Medium"
                case .semiBold:
                    return "Manrope-SemiBold"
                case let .custom(name):
                    return name
            }
        }
    }
    
    public static func manrope(_ type: ManropeFont = .regular, size: CGFloat = 26) -> Font {
        return .custom(type.value, size: size)
    }
    
    public static func manrope(
        _ type: ManropeFont = .regular, size: CGFloat = 26, relativeTo textStyle: Font.TextStyle
    ) -> Font {
        return .custom(type.value, size: size, relativeTo: textStyle)
    }
}
