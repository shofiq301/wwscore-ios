//
//  BottomNavigationBar.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/6/25.
//

import Foundation
import SwiftUI
import XSwiftUI
import EasyX

enum NavBarOptions: String {
  case Home
  case Matches
  case Leagues
  case News
  case More
}

struct NavItem: Identifiable, Hashable {
  let type: NavBarOptions
  let activeIcon: String
  let inactiveIcon: String
  let id: Int
  init(type: NavBarOptions, activeIcon: String, inactiveIcon: String) {
    self.type = type
    self.activeIcon = activeIcon
    self.inactiveIcon = inactiveIcon
    id = type.hashValue
  }
}

// MARK: Bottom Nav Bar

struct BottomNavBar: View {
  @Binding var activeOption: NavBarOptions

  @Binding var items: [NavItem]

  @Environment(\.mainWindowSize) var mainWindowSize

  @Environment(\.safeAreaInsets) private var safeAreaInsets

  @Namespace private var namespace
  var body: some View {
    ZStack(alignment: .bottom) {
      HStack(alignment: .center) {
        ForEach(items) { item in
          VStack(spacing: 0) {
            Button(action: {
              withAnimation(.spring) {
                activeOption = item.type
              }

            }) {
              NavBarItem(
                isSelected: activeOption == item.type,
                name: "\(item.type.rawValue)",
                image: item.inactiveIcon,
                activeImage: item.activeIcon
              )
            }
            .padding(.top, 16)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 3)
          }
        }
      }
      .padding(.horizontal, 20)
      .background(
        Rectangle()
            .foregroundColor(Color.clear)
          .ignoresSafeArea()
      )
    }
    .frame(width: mainWindowSize.width, height: 93, alignment: .topLeading)
  }
}

// MARK: Nav Bar Item

struct NavBarItem: View {
  var isSelected: Bool

  var name: String
  var image: String
  var activeImage: String

  var body: some View {
    VStack {
      if isSelected {
          Image(activeImage, bundle: .main)
          .resizable()
          .renderingMode(.template)
          .foregroundColor(Color(hex: "#87CEEB"))
          .frame(width: 24, height: 24)

        Text(name)
              .font(Font.manrope(.medium, size: 12, relativeTo: .caption2))
              .foregroundColor(Color(hex: "#FFFFFF"))
          .lineLimit(1)

      } else {
          Image(image, bundle: .main)
          .resizable()
          .renderingMode(.template)
          .foregroundColor(Color(hex: "#C2C1C8"))
          .frame(width: 24, height: 24)

        Text(name)
              .font(Font.manrope(.medium, size: 12, relativeTo: .caption2))
          .lineLimit(1)
          .foregroundColor(Color(hex: "#B3B1BA"))
      }
    }

    .foregroundColor(.white)
  }
}

struct BottomNavView_Previews: PreviewProvider {
  static var previews: some View {
    InitialCardView {
      DemoBottomNavView()
    }
  }
}

struct DemoBottomNavView: View {
  @State var activeOption: NavBarOptions = .Home
  @State var items: [NavItem] = [
    NavItem(type: .Home, activeIcon: "home-2", inactiveIcon: "home-2"),
    NavItem(type: .Matches, activeIcon: "Match", inactiveIcon: "Match"),
    NavItem(type: .Leagues, activeIcon: "League", inactiveIcon: "League"),
    NavItem(type: .News, activeIcon: "News", inactiveIcon: "News"),
    NavItem(type: .More, activeIcon: "more", inactiveIcon: "more"),
  ]

  var body: some View {
    ZStack {
      Color.red

      VStack {
        Spacer()
        BottomNavBar(activeOption: $activeOption, items: $items)
          .ignoresSafeArea()
      }
      .ignoresSafeArea()
    }
    .ignoresSafeArea()
  }
}

struct CustomShadowModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .background(
        Rectangle()
          .fill(Color.white)
          .shadow(color: Color.gray.opacity(0.3), radius: 14, x: 0, y: -14)
      )
  }
}


struct CustomLineModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color(hex: "34393E")),
                alignment: .top
            )
    }
}

extension View {
    func customLine() -> some View {
        self.modifier(CustomLineModifier())
    }
}

