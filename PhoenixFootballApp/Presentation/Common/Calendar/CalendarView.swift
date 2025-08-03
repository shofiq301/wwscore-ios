import SwiftUI

struct CustomCalendar: View {
    // Current displayed month and year
    @State private var currentMonth: Int
    @State private var currentYear: Int
    @State private var selectedDay: Int?
    
    // Selection binding
    @Binding var selectedDate: Date
    
    // Optional additional callback
    private var onDateSelected: ((Date) -> Void)?
    
    init(
        selectedDate: Binding<Date>,
        onDateSelected: ((Date) -> Void)? = nil
    ) {
        let calendar = Calendar.current
        let date = selectedDate.wrappedValue
        
        // Initialize with the provided date
        _currentMonth = State(initialValue: calendar.component(.month, from: date))
        _currentYear = State(initialValue: calendar.component(.year, from: date))
        _selectedDay = State(initialValue: calendar.component(.day, from: date))
        
        // Initialize the binding
        _selectedDate = selectedDate
        
        self.onDateSelected = onDateSelected
    }
    
    // Days of the week - using a struct with unique identifiers
    struct WeekDay: Identifiable {
        let id = UUID()
        let name: String
    }
    
    let daysOfWeek = [
        WeekDay(name: "S"),
        WeekDay(name: "M"),
        WeekDay(name: "T"),
        WeekDay(name: "W"),
        WeekDay(name: "T"),
        WeekDay(name: "F"),
        WeekDay(name: "S")
    ]
    
    var body: some View {
        VStack(spacing: 15) {
            // Month header with navigation arrows
            HStack {
                Text(monthName())
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 20) {
                    Button(action: previousMonth) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: nextMonth) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            // Day of week row - fixed to use unique IDs
            HStack(spacing: 0) {
                ForEach(daysOfWeek) { day in
                    Text(day.name)
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                }
            }
            
            // Calendar dates
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 15) {
                ForEach(days(), id: \.id) { day in
                    DayView(
                        day: day.day,
                        isCurrentMonth: day.isCurrentMonth,
                        isSelected: isSelectedDay(day: day.day, isCurrentMonth: day.isCurrentMonth),
                        isToday: isToday(day: day.day, isCurrentMonth: day.isCurrentMonth)
                    )
                        .onTapGesture {
                            if day.isCurrentMonth {
                                selectedDay = day.day
                                
                                // Update the date using the binding
                                if let date = getDate(for: day.day) {
                                    selectedDate = date
                                    
                                    // Call optional callback if provided
                                    onDateSelected?(date)
                                }
                            }
                        }
                }
            }
        }
        .padding()
        .background(Color(hex:"01080E"))
    }
    
    // Check if a day is the selected day in the current view
    private func isSelectedDay(day: Int, isCurrentMonth: Bool) -> Bool {
        if !isCurrentMonth {
            return false
        }
        
        let calendar = Calendar.current
        let selectedDateComponents = calendar.dateComponents([.day, .month, .year], from: selectedDate)
        
        return day == selectedDay &&
               currentMonth == selectedDateComponents.month &&
               currentYear == selectedDateComponents.year
    }
    
    // Check if a day is today
    private func isToday(day: Int, isCurrentMonth: Bool) -> Bool {
        if !isCurrentMonth {
            return false
        }
        
        let calendar = Calendar.current
        let today = Date()
        let todayComponents = calendar.dateComponents([.day, .month, .year], from: today)
        
        return day == todayComponents.day &&
               currentMonth == todayComponents.month &&
               currentYear == todayComponents.year
    }
    
    // Get a Date object for the selected day
    private func getDate(for day: Int) -> Date? {
        var components = DateComponents()
        components.day = day
        components.month = currentMonth
        components.year = currentYear
        
        return Calendar.current.date(from: components)
    }
    
    // Get the name of the current month and year
    func monthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        var components = DateComponents()
        components.month = currentMonth
        components.year = currentYear
        
        if let date = Calendar.current.date(from: components) {
            return dateFormatter.string(from: date)
        }
        
        return "December 2022"
    }
    
    // Go to previous month
    func previousMonth() {
        if currentMonth == 1 {
            currentMonth = 12
            currentYear -= 1
        } else {
            currentMonth -= 1
        }
        
        // Reset the selected day when changing months
        updateSelectedDay()
    }
    
    // Go to next month
    func nextMonth() {
        if currentMonth == 12 {
            currentMonth = 1
            currentYear += 1
        } else {
            currentMonth += 1
        }
        
        // Reset the selected day when changing months
        updateSelectedDay()
    }
    
    // Update the selected day based on the currently selected date
    private func updateSelectedDay() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: selectedDate)
        
        // Only show a selected day if we're viewing the month that contains the selected date
        if components.month == currentMonth && components.year == currentYear {
            selectedDay = components.day
        } else {
            selectedDay = nil
        }
    }
    
    // Calculate the days to display in the calendar
    func days() -> [(id: String, day: Int, isCurrentMonth: Bool)] {
        var days = [(id: String, day: Int, isCurrentMonth: Bool)]()
        
        let calendar = Calendar.current
        
        // Get the first day of the month
        var components = DateComponents()
        components.day = 1
        components.month = currentMonth
        components.year = currentYear
        
        guard let firstDayOfMonth = calendar.date(from: components) else {
            return days
        }
        
        // Get the weekday of the first day (0 is Sunday, 1 is Monday, etc.)
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth) - 1
        
        // Get the number of days in the month
        let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth)!
        let numDays = range.count
        
        // Get the previous month for displaying last days of previous month
        var prevComponents = DateComponents()
        prevComponents.month = currentMonth == 1 ? 12 : currentMonth - 1
        prevComponents.year = currentMonth == 1 ? currentYear - 1 : currentYear
        
        guard let prevMonth = calendar.date(from: prevComponents) else {
            return days
        }
        
        let prevRange = calendar.range(of: .day, in: .month, for: prevMonth)!
        let prevMonthDays = prevRange.count
        
        // Add days from previous month
        for i in 0..<firstWeekday {
            let day = prevMonthDays - firstWeekday + i + 1
            days.append((id: "prev_\(day)", day: day, isCurrentMonth: false))
        }
        
        // Add days from current month
        for day in 1...numDays {
            days.append((id: "current_\(day)", day: day, isCurrentMonth: true))
        }
        
        // Add days from next month to complete the grid
        let remainingDays = 42 - days.count // 6 rows of 7 days
        for day in 1...remainingDays {
            days.append((id: "next_\(day)", day: day, isCurrentMonth: false))
        }
        
        return days
    }
}

struct DayView: View {
    let day: Int
    let isCurrentMonth: Bool
    let isSelected: Bool
    let isToday: Bool
    
    var body: some View {
        Text("\(day)")
            .font(.system(size: 16))
            .fontWeight(isToday || isSelected ? .bold : .medium)
            .frame(width: 35, height: 35)
            .background(
                Circle()
                    .fill(isSelected ? Color.blue : (isToday && !isSelected ? Color.red.opacity(0.3) : Color.clear))
            )
            .foregroundColor(
                isSelected ? .white :
                isToday ? (isCurrentMonth ? .red : .red.opacity(0.6)) :
                isCurrentMonth ? .white : .gray
            )
    }
}

// Example of usage:
struct CalendarExample: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            Text("Selected Date: \(formattedDate(selectedDate))")
                .foregroundColor(.white)
                .padding()
            
            CustomCalendar(
                selectedDate: $selectedDate,
                onDateSelected: { date in
                    selectedDate = date
                    print("Selected date: \(formattedDate(date))")
                }
            )
        }
        .background(Color.black.opacity(0.7))
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct CustomCalendar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.opacity(0.8).edgesIgnoringSafeArea(.all)
            CalendarExample()
        }
    }
}
