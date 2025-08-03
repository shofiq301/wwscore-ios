//
//  KeyEventsViewModel.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/17/25.
//
import SwiftUI
import APIFootball
import XSwiftUI
import EasyXConnect
import EasyX
import SwifterSwift
import SDWebImageSwiftUI
import SDWebImage
import SUIRouter
import PhoenixUI

enum EventType{
    case yellowCard
    case redCard
    case substitutes
    case goad
    case OwnGoal
    case Penalty
    case plentyMiss
}

enum TeamType{
    case Home
    case Away
}
struct MatchEventData: Identifiable{
    let id: String = UUID().uuidString
    let type: EventType
    let time: Int
    let player: String
    let details:String
    let teamType: TeamType
    let assist: String?
    let homeTeamGole: Int
    let awayTeamGole: Int
    
}


final class KeyEventsViewModelBindings: IBindings{
    let fixture:Int
    
    init(fixture: Int) {
        self.fixture = fixture
    }
    
    
    func getDependency()-> KeyEventsViewModel{
        
        
        do{
            let viewMOdel = try? SmartDI.DI.resolve(KeyEventsViewModel.self, name: "\(fixture)", scope: nil)
            
            if let viewModel  = viewMOdel {
                
                return viewModel
                
            }else{
                
                
                let repository =  FixtureKeyEventRepositoryBindings().getDependency()
                
                let viewModel = KeyEventsViewModel(fixture: fixture, repository: repository)
                
                
                SmartDI.DI.register(KeyEventsViewModel.self, name: "\(fixture)" ) { r in
                    viewModel
                }
                
                return viewModel;
                
            }
            
        }
    }
    
    
}

final class KeyEventsViewModel: ObservableObject {
    
    let fixture:Int
    private let repository: IFixtureKeyEventRepository
    
    init(fixture: Int, repository: IFixtureKeyEventRepository) {
        self.fixture = fixture
        self.repository = repository
        
        
        Task{
            await getEvents()
        }
    }
    @Published var eventList:[FixtureKeyEventsData] = []
    @Published var loading:Bool = false
    
    @MainActor
    func getEvents()async{
        
        do{
            loading = true
            let list = try await repository.getEventsByfixture(fixture: fixture)
            
            eventList = list
            
            
        }catch{
            print("error is => \(error)")
        }
        loading = false
    }
    
    func getEventsList(home: Int) -> [MatchEventData]{
        
        var list :[MatchEventData] = []
        var currentHomeGoals = 0
        var currentAwayGoals = 0

        for v in eventList {
            var type: EventType = .yellowCard

            switch v.type {
            case "Card":
                if v.detail == "Yellow Card" {
                    type = .yellowCard
                } else if v.detail == "Red Card" {
                    type = .redCard
                }
            case "Goal":
                if v.detail == "Own Goal" {
                    type = .OwnGoal
                } else if v.detail == "Penalty" {
                    type = .Penalty
                } else if v.detail == "Missed Penalty" {
                    type = .plentyMiss
                } else {
                    type = .goad
                }
            case "subst":
                type = .substitutes
            case "Var":
                if v.detail == "Goal cancelled" || v.detail == "Penalty confirmed" {
                    type = .plentyMiss
                }
            default:
                break
            }

            let teamType: TeamType  = v.team.id == home ?  .Home : .Away

            //calculate goal for home and away teams from previous events
            if v.type == "Goal", v.detail != "Missed Penalty", v.detail != "Goal cancelled" {
                if v.detail == "Own Goal" {
                    if v.team.id == home {
                        currentAwayGoals += 1
                    } else {
                        currentHomeGoals += 1
                    }
                } else {
                    if v.team.id == home {
                        currentHomeGoals += 1
                    } else {
                        currentAwayGoals += 1
                    }
                }
            }

            let data = MatchEventData(
                type: type,
                time: v.time.elapsed.getTime(),
                player: v.player.name ?? "",
                details: v.detail,
                teamType: teamType,
                assist: v.assist.name,
                homeTeamGole: currentHomeGoals,
                awayTeamGole: currentAwayGoals
            )

            list.append(data)
        }
        
        return list
        
    }
}
