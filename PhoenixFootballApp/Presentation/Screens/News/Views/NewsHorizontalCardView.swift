//
//  NewsHorizontalCardView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/7/25.
//


import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct NewsHorizontalCardView: View {
    let news: NewsDoc
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
  var body: some View {
    VStack(alignment: .leading, spacing: 14) {

      MediaView(
        model: MediaContentModel(
          mediaType: .image,
          imageURL:
            news.image,
          videoData: nil, gifURL: nil)
      )
      .frame(width: 320.width(), height: 209.width(), alignment: .center)
      .cornerRadius(20, corners: .allCorners)

        Text(news.title ?? "")
        .font(.manrope(.semiBold, size: 16))
        .multilineTextAlignment(.leading)
        .lineLimit(2)
        .foregroundStyle(.white)
        .frame(maxHeight: .infinity)

        Text(news.getTimeAgo())
        .font(.manrope(.medium, size: 10))
        .foregroundStyle(.secondary)
        .foregroundStyle(Color(hex: "B3B1BA"))

    }
    .frame(width: 320.width(), height: 290.width(), alignment: .leading)
    .padding(.vertical)
    .onTapGesture {
        pilot.push(.NewsDetails(news: news))
    }
  }
}



struct NewsHorizontalCardSmallView: View {
    let news: NewsDoc
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
  var body: some View {
    VStack(alignment: .leading, spacing: 14) {

      MediaView(
        model: MediaContentModel(
          mediaType: .image,
          imageURL:
            news.image,
          videoData: nil, gifURL: nil)
      )
      .frame(maxWidth: .infinity)
      .frame( height: 174.width(), alignment: .center)
      .cornerRadius(20, corners: .allCorners)

        Text(news.title ?? "")
        .font(.manrope(.semiBold, size: 16))
        .multilineTextAlignment(.leading)
        .lineLimit(2)
        .foregroundStyle(.white)
        .frame(maxHeight: .infinity)

        Text(news.getTimeAgo())
        .font(.manrope(.medium, size: 10))
        .foregroundStyle(.secondary)
        .foregroundStyle(Color(hex: "B3B1BA"))

    }
    .frame(maxWidth: .infinity)
    .frame( height: 264.width(), alignment: .leading)
    .padding(.vertical)
    .onTapGesture {
        pilot.push(.NewsDetails(news: news))
    }
  }
}
