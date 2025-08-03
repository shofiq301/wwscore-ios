//
//  HomeHeader.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/12/25.
//

import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct HomeHeader: View {
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
    let onCalentderTap:()->Void
  var body: some View {
    HStack {
      Image(.footyStrikeIcon)

      Spacer()
      HStack(spacing: 16) {

        Button(action: {}) {
          Image(.searchIcon)
        }
        .buttonStyle(.plain)

        Button(action: {
            onCalentderTap()
        }) {
          Image(.faCalendarAlt)
        }
        .buttonStyle(.plain)

          Button(action:{
              pilot.push(.LiveMatchPage)
          }){
            Text("Live")
              .font(.manrope(.medium, size: 11))
              .foregroundStyle(.white)
              .padding(.horizontal, 16)
              .padding(.vertical, 8)
              .background(
                RoundedRectangle(cornerRadius: 50)
                  .stroke(Color.white, lineWidth: 1)  // White border
              )
        }
      }

    }
  }
}
