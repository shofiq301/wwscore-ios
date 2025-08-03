//
//  FootballLeaguesView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/18/25.
//


import SwiftUI
import XSwiftUI
import PhoenixUI
import APIFootball
import SUIRouter

struct FootballLeaguesView: View {
    
    @Binding var isSearchActive: Bool
    @EnvironmentObject var leaguesListViewModel:LeaguesListViewModel
    @EnvironmentObject private var pilot: UIPilot<AppRoute>
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                
                if isSearchActive == false{
                    // Top League section
                    LazyVStack(alignment: .leading, spacing: 12) {
                        Text("Top League")
                            .font(.manrope(.semiBold, size: 14))
                            .foregroundColor(Color(hex:"C2C1C8"))
                            .padding(.horizontal)
                            .padding(.top, 10)
                        
                        ForEach(leaguesListViewModel.getTopLeagues(), id: \.id) { league in
                            LeagueRow(league: league){
                                if let l = leaguesListViewModel.getLeagueByID(id: league.id){
                                    pilot.push(.leagueDetails(league: l))
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 16)
                    AllCompetitionSection(
                        allCompetitions: leaguesListViewModel.visibleCompetitions,
                        flagMap: leaguesListViewModel.flagMap,
                        isSearching: nil,
                        loadMore: {
                            leaguesListViewModel.loadMoreCompetitions()
                        },
                        onLeagueSelected: { league in
                            if let l = leaguesListViewModel.getLeagueByID(id: league.id){
                                pilot.push(.leagueDetails(league: l))
                            }
                        }
                    )
                }else{
                    AllCompetitionSection(
                        allCompetitions: leaguesListViewModel.visibleCompetitions,
                        flagMap: leaguesListViewModel.flagMap,
                        isSearching: isSearchActive,
                        loadMore: {
                            leaguesListViewModel.loadMoreCompetitions()
                        },
                        onLeagueSelected: { league in
                            if let l = leaguesListViewModel.getLeagueByID(id: league.id){
                                pilot.push(.leagueDetails(league: l))
                            }
                        }
                    )
                }
                
                
               
            }
            .padding(.all, 10)
            .background(Color(hex: "01080E"))
            .cornerRadius(10, corners: .allCorners)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(hex: "34393E"), lineWidth: 0.5)
            }
            
            
        }
        
        

        
        
    }
}

struct AllCompetitionSection: View {
    @State private var expandedSections: Set<String> = []
    let allCompetitions: [(section: String, leagues: [LeagueDetailsData])]
    let flagMap: [String: String]
    let isSearching: Bool?
    let loadMore: () -> Void
    let onLeagueSelected: (LeagueDetailsData) -> Void

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 12) {
            Text("All Competitions")
                .font(.manrope(.semiBold, size: 14))
                .foregroundColor(Color(hex: "C2C1C8"))
                .padding(.horizontal)
                .padding(.top, 10)

            // If you want them sorted by section name:
            let sorted = allCompetitions //.sorted { $0.section < $1.section }

            ForEach(Array(sorted.enumerated()), id: \.1.section) { index, item in
                CompetitionSectionRow(
                    section: item.section,
                    isExpanded: isSearching ?? expandedSections.contains(item.section),
                    countryIcon: flagMap[item.section],
                    leagues: item.leagues,
                    toggleExpand: {
                        if expandedSections.contains(item.section) {
                            expandedSections.remove(item.section)
                        } else {
                            expandedSections.insert(item.section)
                        }
                    }
                    ,
                    onLeagueSelected: { league in
                    
                        onLeagueSelected(league)
                    }
                )
                // 👇 Trigger load‑more when the last section comes into view
                .onAppear {
                    if index == sorted.count - 1 {
                        loadMore()
                    }
                }
            }
        }
    }
}
