//
//  NewsDetailsScreen.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 6/30/25.
//

import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI
import PhoenixUI

struct NewsDetailsScreen: View {
  let news: NewsDoc
  @EnvironmentObject private var pilot: UIPilot<AppRoute>
  @EnvironmentObject var themeManager: ThemeManager
  var body: some View {
    VStack {
        ScrollView{
            VStack{
                VStack(alignment: .leading, spacing: 14) {

                  MediaView(
                    model: MediaContentModel(
                      mediaType: .image,
                      imageURL:
                        news.image,
                      videoData: nil, gifURL: nil)
                  )
                  .frame(maxWidth: .infinity)
                  .frame( height: 209.width(), alignment: .center)
                  .cornerRadius(20, corners: .allCorners)

                    Text(news.title ?? "")
                    .font(.manrope(.semiBold, size: 16))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .foregroundStyle(.white)
                   

                    Text(news.getTimeAgo())
                    .font(.manrope(.medium, size: 10))
                    .foregroundStyle(.secondary)
                    .foregroundStyle(Color(hex: "B3B1BA"))

                }
                .frame( alignment: .leading)
                
                
                //show html text here
                if let htmlString = news.content, !htmlString.isEmpty {
                    DynamicHeightHTMLView(html: htmlString)
                } else {
                    Text("No content available")
                        .font(.manrope(.medium, size: 14))
                        .foregroundStyle(.secondary)
                        .padding(.top, 16)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
    }
    
    .frame(maxWidth: .infinity, maxHeight: .infinity)
      
    .background(themeManager.currentTheme.background.sd900)
    .appBar(
      title: "News", trailing: {},
      leading: {

        AppBackButton {
          pilot.pop()
        }
      })
  }
}
