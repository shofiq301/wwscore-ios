//
//  OnboadingViewItem.swift
//  PhoenixFootballApp
//
//  Created by Md Shofiulla on 9/3/25.
//
import Foundation
struct OnboadingViewItem: Identifiable {
    let id = UUID()
    let title: String
    let text: String
    let image: String
    
    init(title: String, text: String, image: String) {
        self.title = title
        self.text = text
        self.image = image
    }
}
extension OnboadingViewItem {
    static let items: [OnboadingViewItem] = [
        .init(title: "Welcome to Footy Strike!",
              text: "Experience football like never before with FOOTY Strike",
              image: "img1"),
        .init(title: "Your Gateway to Football Excellence",
              text: "Your ultimate football companion. Stay updated with live scores, schedules, and player information",
              image: "img2"),
        .init(title: "Never Miss a Match Again",
              text: "Get instant updates, live scores, and notifications for all your favorite games",
              image: "img2"),
    ]
}
