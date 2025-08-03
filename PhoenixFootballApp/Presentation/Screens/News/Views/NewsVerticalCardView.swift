//
//  NewsVerticalCardView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/7/25.
//

import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct NewsVerticalCardView: View {
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
    let news: NewsDoc
    var body: some View {
        VStack{
            HStack(spacing: 14){
                MediaView(
                  model: MediaContentModel(
                    mediaType: .image,
                    imageURL:
                        news.image,
                    videoData: nil, gifURL: nil)
                )
                .frame(width: 162.width(), height: 92.width(), alignment: .center)
                .cornerRadius(10, corners: .allCorners)
                
                VStack(alignment: .leading){
                    Text(news.title ?? "")
                        .font(.manrope(.medium, size: 14))
                      .multilineTextAlignment(.leading)
                      .lineLimit(3)
                      .foregroundStyle(.white)
                    Spacer()

                    Text(news.getTimeAgo())
                      .font(.manrope(.medium, size: 10))
                      .foregroundStyle(.secondary)
                      .foregroundStyle(Color(hex: "B3B1BA"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(height: 92.width())
        .onTapGesture {
            pilot.push(.NewsDetails(news: news))
        }
    }
}
