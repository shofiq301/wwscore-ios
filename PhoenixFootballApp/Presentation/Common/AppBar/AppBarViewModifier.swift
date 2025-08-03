//
//  AppBarViewModifier.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/7/25.
//


import Foundation
import SwiftUI

struct AppBarViewModifier<Leading: View, Trailing: View>: ViewModifier {
  let title: LocalizedStringKey
  let trailing: Trailing?
  let leading: Leading?

  init(
    title: LocalizedStringKey,
    @ViewBuilder trailing: () -> Trailing,
    @ViewBuilder leading: () -> Leading
  ) {
    self.title = title
    self.trailing = trailing()
    self.leading = leading()
  }

  func body(content: Content) -> some View {
    content
      .toolbar {
        ToolbarItem(placement: .principal) {
            Text(title)
                .font(.manrope(.medium, size: 20))  // Customize font here
            .foregroundColor(Color(hex: "#ffffff"))  // Customize color here
        }
        ToolbarItem(placement: .navigationBarLeading) {
          leading
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          trailing
        }
      }
      .navigationBarBackButtonHidden(true)
      .navigationBarTitleDisplayMode(.inline)
  }
}

public extension View {
    func appBar<Leading: View, Trailing: View>(
        title: String,
    @ViewBuilder trailing: @escaping () -> Trailing,
    @ViewBuilder leading: @escaping () -> Leading
  ) -> some View {
    self.modifier(AppBarViewModifier(title: LocalizedStringKey(title), trailing: trailing, leading: leading))
  }
}
