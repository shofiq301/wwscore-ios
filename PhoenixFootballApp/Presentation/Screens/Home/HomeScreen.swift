//
//  HomeScreen.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/6/25.
//

import EasyX
import SUIRouter
import SwiftUI
import XSwiftUI

final class HomeTabControlerBindings: IBindings {
  func getDependency() -> HomeTabControler {
    if let viewModel = try? DIContainer.shared.resolve(HomeTabControler.self) {
      return viewModel
    }
    let viewModel = HomeTabControler()
    DIContainer.shared.register(HomeTabControler.self, factory: { _ in viewModel })
    return viewModel

  }
}

class HomeTabControler: ObservableObject {
  @Published var activeOption: NavBarOptions = .Home
}

struct HomeScreen: View {
    // @State var activeOption: NavBarOptions = .Home
    
    @StateObject var homeController: HomeTabControler = HomeTabControlerBindings().getDependency()
    @State var items: [NavItem] = [
        NavItem(type: .Home, activeIcon: "home-2", inactiveIcon: "home-2"),
        NavItem(type: .Matches, activeIcon: "Match", inactiveIcon: "Match"),
        NavItem(type: .Leagues, activeIcon: "League", inactiveIcon: "League"),
        NavItem(type: .News, activeIcon: "News", inactiveIcon: "News"),
        NavItem(type: .More, activeIcon: "more", inactiveIcon: "more"),
    ]
    
    @Environment(\.mainWindowSize) var mainWindowSize
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @StateObject var leaguesListViewModel: LeaguesListViewModel = LeaguesListViewModelBindings()
        .getDependency()
    
    var body: some View {
        
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                
                switch homeController.activeOption {
                case .Home:
                    HomeBody()
                case .Matches:
                    MatchesHomeView()
                case .Leagues:
                    LeaguesHomeScreen()
                case .News:
                    NewsListHome()
                case .More:
                    SettingsHomeScreen()
                }
            }
            .frame(maxHeight: .screenHeight, alignment: .leading)
            BottomNavBar(activeOption: $homeController.activeOption, items: $items)
                .modifier(CustomLineModifier())
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .background(Color(hex: "01080E"))
        .environmentObject(leaguesListViewModel)
        .environmentObject(homeController)
        .task {
            await leaguesListViewModel.getAllLeagues()
        }
    }
}

#Preview{
  ContentView()
}
