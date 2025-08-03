//
//  ViewExtensions.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/8/25.
//

import SwiftUI

extension View {
    func border(width: CGFloat, color: Color, cornerRadius: CGFloat) -> some View {
        overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: width)
        )
    }
}

/*
 Example 
 .background(Color.black)
 .cornerRadius(10)
 .border(width: 1, color: Color(hex: "34393E"), cornerRadius: 10)
 .padding()
 */
