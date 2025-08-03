//
//  SportsCategoryTabs.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/7/25.
//

import PhoenixUI
import SwiftUI

struct SportsCategoryTabs: View {
  @State private var selectedCategory: String = "All"
//  private let categories = ["All", "World Cup 2022", "La Liga", "Europa L"]

    let categories:[NewsCategoryModel]
    
    let onSelectCategory: (Int?) -> Void
    
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 10) {
        ForEach(categories, id: \.self) { category in
          Button(action: {
              selectedCategory = category.id
              onSelectCategory(category.datumID)
          }) {
              Text(category.name ?? "")
              .font(.manrope(.medium, size: 14))
              .padding(.horizontal, 18)
              .padding(.vertical, 8)
              .background(
                Capsule()
                    .fill(selectedCategory == category.id ? Color(hex: "1976D2") : Color.clear)
                  .overlay(
                    Capsule()
                      .stroke(Color(hex: "4791DB"), lineWidth: 1)
                  )
              )
              .foregroundColor(selectedCategory == category.id ? .white : Color(hex: "1976D2"))
              .font(.system(size: 14, weight: .medium))
          }
        }
      }
      .padding(.horizontal, 10)
      .padding(.vertical, 2)
    }
  }
}
