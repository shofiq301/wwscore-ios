//
//  DateNavigationBar.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/13/25.
//

import PhoenixUI
import SwiftUI
import XSwiftUI

struct DateTab: Identifiable {
  let id = UUID()
  let date: Date
  let displayText: String
}
struct DateNavigationBar: View {
  @State private var selectedTab = 15  // "Today" is selected by default (index 15 in the middle)
  @State private var dateTabs: [DateTab] = []
    @Binding var selectedDate: Date
    //let onDateCHange: (Date) -> Void

    init(selectedDate: Binding<Date>) {
       
        //self.onDateCHange = onDateCHange
        _selectedDate = selectedDate
        _dateTabs = State(initialValue: generateDateTabs())
    }

  var body: some View {
    ScrollViewReader { scrollProxy in
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 20) {
          ForEach(0..<dateTabs.count, id: \.self) { index in
            Button(action: {
              selectedTab = index
                selectedDate = dateTabs[index].date
              //  onDateCHange(dateTabs[index].date)
            }) {
              Text(dateTabs[index].displayText)
                    .font(.manrope(.medium, size: 14))
                    .foregroundColor(selectedTab == index ? Color(hex: "1976D2") : Color(hex:"C2C1C8"))
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
            }
            .id(index)  // Add id for ScrollViewReader
            .background(
              VStack {
                Spacer()
                if selectedTab == index {
                  Rectangle()
                    .frame(height: 6)
                    .foregroundColor(Color(hex: "1976D2"))
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
            .foregroundColor(Color(hex: "34393E"))
        }
      )
      .onChange(of: selectedDate) { newValue in
          if let index = dateTabs.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: newValue) }) {
              selectedTab = index
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                  withAnimation {
                      scrollProxy.scrollTo(index, anchor: .center)
                  }
              }
          }
      }
      .onAppear {
        // Scroll to "Today" when the view appears
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//          withAnimation {
//            // Scroll to the "Today" tab (index 15)
//            scrollProxy.scrollTo(15, anchor: .center)
//          }
            scrollProxy.scrollTo(15, anchor: .center)
        }
      }
    }

    // Structure to hold date information

  }
  // Generate 31 date tabs: 15 days before today, today, and 15 days after today
  private func generateDateTabs() -> [DateTab] {
    let calendar = Calendar.current
    let today = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE d MMM"  // Format: "Sun 15 Apr"

    var tabs: [DateTab] = []

    // Generate 15 days before today
    for daysOffset in -15...15 {
      if let date = calendar.date(byAdding: .day, value: daysOffset, to: today) {
        var displayText: String

        // Special cases for yesterday, today, and tomorrow
        if daysOffset == -1 {
          displayText = "Yesterday"
        } else if daysOffset == 0 {
          displayText = "Today"
        } else if daysOffset == 1 {
          displayText = "Tomorrow"
        } else {
          // Regular date format
          displayText = dateFormatter.string(from: date)
        }

        tabs.append(DateTab(date: date, displayText: displayText))
      }
    }

    return tabs
  }
}
