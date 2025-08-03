//
//  TabsWithIcon.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/12/25.
//




import PhoenixUI
import SwiftUI
import XSwiftUI

struct TabData: Sendable, Identifiable, Equatable, Hashable {
    let title: String
    let image: String
    
    var id: String { title } // Use title as the unique identifier
}

struct TabsWithIcon: View {
  @State private var selectedCategory: TabData = TabData(title: "ALL", image: "")
    private let categories:[TabData] = //["All", "Bangladesh", "La Liga", "Europa L"]

    [
        TabData(title: "ALL", image: ""),
        TabData(title: "Bangladesh", image: "https://media-4.api-sports.io/football/teams/1560.png"),
        TabData(title: "England", image: "https://media-4.api-sports.io/football/teams/10.png"),
        TabData(title: "Brazil", image: "https://media-4.api-sports.io/football/teams/6.png"),
    ]
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 10) {
        ForEach(categories, id: \.self) { category in
          Button(action: {
            selectedCategory = category
          }) {
              
              HStack{
                  if category.image.isWebURL{
                      MediaView(
                        model: MediaContentModel(
                            mediaType: .image,
                            imageURL: category.image,
                            videoData: nil,
                            gifURL: nil
                        )
                      )
                      .frame(width: 16, height: 16)
                      .cornerRadius(8, corners: .allCorners)
                  }
                
                  
                  Text(category.title)
                  .font(.manrope(.medium, size: 14))
//                  .foregroundStyle(Color(hex: "1976D2"))
              }
              .padding(.horizontal, 18)
              .padding(.vertical, 8)
              .background(
                Capsule()
                  .fill(selectedCategory == category ? Color(hex: "1976D2") : Color.clear)
                  .overlay(
                    Capsule()
                      .stroke(Color(hex: "4791DB"), lineWidth: 1)
                  )
              )
              .foregroundColor(selectedCategory == category ? .white : Color(hex: "1976D2"))
//              .font(.system(size: 14, weight: .medium))
          }
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 2)
    }
  }
}
