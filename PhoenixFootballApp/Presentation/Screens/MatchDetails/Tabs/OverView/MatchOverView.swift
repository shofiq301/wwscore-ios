//
//  MatchOverView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/18/25.
//



import APIFootball
import Combine
import SUIRouter
import SwiftUI
import XSwiftUI

struct MatchOverView: View {
  let fixture: FixtureDataResponse
  var body: some View {
    VStack {
      MatchVenueView(fixture: fixture)
    }
  }
}

struct MatchVenueView: View {
  let fixture: FixtureDataResponse
  @EnvironmentObject var themeManager: ThemeManager
  var body: some View {
    VStack(spacing: 18) {

      rowBuilder(
        image: .tiCalendar,
        title: fixture.fixture.getStartDate(dateFormat: "EEE, MMM d, yyyy, h:mm a"))

      if let venue = fixture.fixture.venue.name {
        rowBuilder(image: .statium, title: venue)
      }

      if let refree = fixture.fixture.referee {
        rowBuilder(image: .rafree, title: refree)
      }

    }
    .padding(.all, 20)
    .background(themeManager.currentTheme.background.sd500)
    .border(width: 1, color: themeManager.currentTheme.background.sd400, cornerRadius: 16)
  }

  @ViewBuilder
  func rowBuilder(image: ImageResource, title: String) -> some View {
    HStack(spacing: 32) {
      Image(image)
        .frame(width: 24, height: 24)

      Text(title)
        .body1Semebold()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)

    }
  }
}

struct MatchTimelineView: View {
  @EnvironmentObject  var viewModel: KeyEventsViewModel
  private let homeTeamId: Int
  @EnvironmentObject var themeManager: ThemeManager
  init(fixture: Int, homeTeamId: Int) {
  //  self._viewModel = StateObject(
    //  wrappedValue: KeyEventsViewModelBindings(fixture: fixture).getDependency())
    self.homeTeamId = homeTeamId
  }

  var body: some View {
    ZStack {
      ScrollView {
        VStack(spacing: 0) {

          // Timeline events
          KeyMatchEventsCard(events: viewModel.getEventsList(home: homeTeamId))
                .padding(.bottom, 20)
            
            KeyEventLogoDescription()
                .padding(.bottom, 50)
            

        }
      }
    }
    .background(themeManager.currentTheme.background.sd500)
  }
}


struct KeyEventLogoDescription:View {
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        VStack(spacing: 10){
            
            HStack{
                optionBuilder(image: .substitutes, title: "Substitution")
                optionBuilder(image: .redCard, title: "Red Card")
                optionBuilder(image: .yellowCard, title: "Yellow Card")
                
            }
            
            HStack{
                optionBuilder(image: .goal, title: "Goal")
                optionBuilder(image: .ownGoal, title: "Own-goal")
                optionBuilder(image: .penalty, title: "Penalty")
                optionBuilder(image: .goalMissed, title: "Penalty Missed")
            }
            
        }
        .padding(.all, 16)
        .frame(maxWidth: .infinity)
        .background(themeManager.currentTheme.background.sd400)
        .cornerRadius(4, corners: .allCorners)
    }
    
    func optionBuilder(image: ImageResource, title:String)-> some View{
        HStack{
            Image(image)
                .frame(width: 20, height: 20, alignment: .center)
            Text(title)
                .captionMedium()
                .foregroundStyle(.white)
        }
    }
}

struct KeyMatchEventsCard: View {

  var events: [MatchEventData]

  @Environment(\.mainWindowSize) var mainWindowSize
  @EnvironmentObject var themeManager: ThemeManager

  var body: some View {

    if events.isEmpty {

      EmptyView()
    } else {

      VStack(alignment: .center, spacing: 0) {

        Image(.matchStartEnd)
          .frame(width: 36, height: 36)
          

        VStack {
            Divider()
              .frame(width: 1, height: 16)
              .background(themeManager.currentTheme.background.sd400)
            
          ForEach(events.reversed()) { event in

            if event.teamType == .Home {
              getLeftCard(event: event)
            } else {
              getRightCard(event: event)
            }
          }
        }

        Image(.matchStartEnd)
          .frame(width: 36, height: 36)

      }
    }
  }

  func getRightCard(event: MatchEventData) -> some View {

    HStack(alignment: .top, spacing: 0) {
      Spacer()
      VStack(spacing: 4) {
        switch event.type {
        case .redCard:
          Image(.redCard)
            .frame(width: 20, height: 20)
        case .yellowCard:
          Image(.yellowCard)
            .frame(width: 20, height: 20)
        case .goad:
          Image(.goal)
            .frame(width: 20, height: 20)
        case .substitutes:
          Image(.substitutes)
            .frame(width: 20, height: 20)
        case .plentyMiss:
          Image(.goalMissed)
            .frame(width: 20, height: 20)

        case .OwnGoal:
          Image(.ownGoal)
            .frame(width: 20, height: 20)
        case .Penalty:
          Image(.penalty)
            .frame(width: 20, height: 20)
        }

        Text("\(event.time)’")
          .captionMedium()
          .foregroundStyle(.white)
          
          if event.type == .goad || event.type == .Penalty || event.type == .OwnGoal || event.type == .plentyMiss{
              Text("\(event.homeTeamGole)-\(event.awayTeamGole)")
                .captionMedium()
                .foregroundStyle(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(themeManager.currentTheme.primary.sd900)
                .cornerRadius(16, corners: .allCorners)
          }

        Divider()
          .frame(width: 1, height: 16)
          .background(themeManager.currentTheme.background.sd400)
      }
      VStack(alignment: .leading) {

        if event.type == .redCard || event.type == .yellowCard {
          Text("Card: \(event.player) ")
            .body2Medium()
            .foregroundStyle(.white)
        }
          else if event.type == .substitutes{
              Text("In: \(event.player)")
                .body2Medium()
                .foregroundStyle(.white)

              Text("Out: \(event.assist ?? event.details)")
                .body2Medium()
                .foregroundStyle(themeManager.currentTheme.text.sd700)
          }
          else if event.type == .goad || event.type == .OwnGoal || event.type == .Penalty{
              Text("Goal: \(event.player)")
                .body2Medium()
                .foregroundStyle(.white)

              Text("\(event.assist ?? event.details)")
                .body2Medium()
                .foregroundStyle(themeManager.currentTheme.text.sd700)
          }
          
          else {
          Text("\(event.player)")
            .body2Medium()
            .foregroundStyle(.white)

          Text("\(event.assist ?? event.details)")
            .body2Medium()
            .foregroundStyle(themeManager.currentTheme.text.sd700)
        }

      }
      .padding(.leading, 10)
      .frame(width: (mainWindowSize.width * 0.5) - 10, alignment: .leading)

    }

  }

  func getLeftCard(event: MatchEventData) -> some View {
    HStack(alignment: .top, spacing: 0) {

      VStack(alignment: .trailing) {

        if event.type == .redCard || event.type == .yellowCard {
          Text("Card: \(event.player) ")
            .body2Medium()
            .foregroundStyle(.white)
        }
         else if event.type == .substitutes{
              Text("In: \(event.player)")
                .body2Medium()
                .foregroundStyle(.white)
              Text("Out: \(event.assist ?? event.details)")
                .body2Medium()
                .foregroundStyle(themeManager.currentTheme.text.sd700)
          }
          else if event.type == .goad || event.type == .OwnGoal || event.type == .Penalty{
              Text("Goal: \(event.player)")
                .body2Medium()
                .foregroundStyle(.white)

              Text("\(event.assist ?? event.details)")
                .body2Medium()
                .foregroundStyle(themeManager.currentTheme.text.sd700)
          }
          else {
          Text("\(event.player)")
            .body2Medium()
            .foregroundStyle(.white)
          Text("\(event.assist ?? event.details)")
            .body2Medium()
            .foregroundStyle(themeManager.currentTheme.text.sd700)
        }

      }
      .padding(.trailing, 10)
      .frame(width: (mainWindowSize.width * 0.5) - 10, alignment: .trailing)

      VStack(spacing: 4) {
        switch event.type {
        case .redCard:
          Image(.redCard)
            .frame(width: 20, height: 20)
        case .yellowCard:
          Image(.yellowCard)
            .frame(width: 20, height: 20)
        case .goad:
          Image(.goal)
            .frame(width: 20, height: 20)
        case .substitutes:
          Image(.substitutes)
            .frame(width: 20, height: 20)
        case .plentyMiss:
          Image(.goalMissed)
            .frame(width: 20, height: 20)

        case .OwnGoal:
          Image(.ownGoal)
            .frame(width: 20, height: 20)
        case .Penalty:
          Image(.penalty)
            .frame(width: 20, height: 20)
        }

        Text("\(event.time)’")
          .captionMedium()
          .foregroundStyle(.white)
          
          if event.type == .goad || event.type == .Penalty || event.type == .OwnGoal || event.type == .plentyMiss{
              Text("\(event.homeTeamGole)-\(event.awayTeamGole)")
                .captionMedium()
                .foregroundStyle(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(themeManager.currentTheme.primary.sd900)
                .cornerRadius(16, corners: .allCorners)
          }
         

        Divider()
          .frame(width: 1, height: 16)
          .background(themeManager.currentTheme.background.sd400)
      }

      Spacer()
    }
  }

}
