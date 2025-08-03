//
//  RouteSetupView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/6/25.
//

import SwiftUI
import SUIRouter
import EasyX

public struct RouteSetupView<Content: View>: View {

  @StateObject var pilot: UIPilot<AppRoute>
  @ViewBuilder var content: Content

  public init(
    pilot: UIPilot<AppRoute>,
    @ViewBuilder content: @escaping (_ pilot: UIPilot<AppRoute>) -> Content
  ) {
    pilot.addObserver(ScopeCleanupObserver())
    _pilot = StateObject(wrappedValue: pilot)
    self.content = content(pilot)
      SmartDI.shared.registerSelf(stacks: {pilot.stack})
  }

  public var body: some View {
    content
         
  }
}
