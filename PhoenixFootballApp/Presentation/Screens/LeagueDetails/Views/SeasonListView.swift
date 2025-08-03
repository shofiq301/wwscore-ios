//
//  SeasonListView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/2/25.
//

import APIFootball
import EasyX
import EasyXConnect
import PhoenixUI
import SDWebImage
import SDWebImageSwiftUI
import SUIRouter
import SwiftUI
import SwifterSwift
import XSwiftUI


struct SeasonListView: View {
  @Binding var isSheetPresented: Bool
  @StateObject var tournementVM: LeagueDetailsViewModel
  init(model: LeagueData, isSheetPresented: Binding<Bool>) {
    _isSheetPresented = isSheetPresented
    _tournementVM = StateObject(
      wrappedValue: LeagueDetailsViewModelBindings(leagueID: model.league.id).getDependency())
  }
  var body: some View {

    VStack {
        
        Text("Seasons")
            .font(.manrope(.bold, size: 20))
            .fontWeight(.medium)
            .foregroundColor(.black)
        
      ScrollView {
        VStack {

          let reversedSeasons = tournementVM.seasonList.reversed()

          ForEach(reversedSeasons, id: \.year) { data in
            let isCurrent = tournementVM.currentSeason == data.year

            Button(action: {
              if tournementVM.currentSeason != data.year {
                tournementVM.currentSeason = data.year
                Task {
                  await tournementVM.loadSeason()
                }
              }
              isSheetPresented.toggle()
            }) {
              VStack {
                Text("\(data.seasonName)")
                  .font(.manrope(.bold, size: 18))
                  .fontWeight(.medium)
                  .foregroundColor(isCurrent ? .red : .black)
                Divider()
              }
            }
          }

        }
      }
    }
    .padding()
    .background(Color.white)
    .cornerRadius(15)

  }

}
