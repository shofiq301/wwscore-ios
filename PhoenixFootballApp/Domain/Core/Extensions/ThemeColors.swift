//
//  AppColor.swift
//  PhoenixFootballApp
//
//  Created by Md Shofiulla on 10/3/25.
//
import SwiftUI
enum ThemeColors: String {
    case primary
    case secondary
    case backgroundColor = "befaultBgColor"
    case defaultTextColor
    case defaultIconColor
    case accent

    var color: Color {
        return Color(self.rawValue)
    }
}
