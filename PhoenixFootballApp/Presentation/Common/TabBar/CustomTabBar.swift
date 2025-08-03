//
//  CustomTabBar.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 5/2/25.
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

struct CustomTabBar: View {
    let tabs: [String]
    @Binding var selectedTab: Int
    let activeColor: Color
    let inactiveColor: Color
    let dividerColor: Color
    let labelColor: Color
    
    init(tabs: [String], selectedTab: Binding<Int>,
         activeColor: Color = Color(hex: "1976D2"),
         inactiveColor: Color = Color(hex: "C2C1C8"),
         dividerColor: Color = Color.clear,
         labelColor: Color = Color(hex: "1976D2")
    ) {
        self.tabs = tabs
        self._selectedTab = selectedTab
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
        self.dividerColor = dividerColor
        self.labelColor = labelColor
    }
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        Button(action: {
                            withAnimation {
                                selectedTab = index
                            }
                        }) {
                            Text(tabs[index])
                                .font(.manrope(.medium, size: 14))
                                .foregroundColor(selectedTab == index ? activeColor : inactiveColor)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                        }
                        .id(index)  // Add id for ScrollViewReader
                        .background(
                            VStack {
                                Spacer()
                                if selectedTab == index {
                                    Rectangle()
                                        .frame(height: 4)
                                        .foregroundColor(labelColor)
                                        .cornerRadius(3, corners: [.topLeft, .topRight])
                                }
                            }
                        )
                    }
                }
                .padding(.horizontal)
            }
            .background(
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(dividerColor)
                }
            )
            .onAppear {
                // Scroll to selected tab when the view appears
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    scrollProxy.scrollTo(selectedTab, anchor: .center)
                }
            }
            .onChange(of: selectedTab) { newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        scrollProxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
        }
    }
}
