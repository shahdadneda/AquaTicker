//
//  ContentView.swift
//  AquaTicker
//
//  Created by Shahdad Neda on 2025-03-25.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            // Main gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.85, green: 0.95, blue: 1.0),
                    Color(red: 0.7, green: 0.85, blue: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // Decorative circles
            Circle()
                .fill(Color.white)
                .frame(width: 300, height: 300)
                .blur(radius: 30)
                .offset(x: -150, y: -100)
            
            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 200, height: 200)
                .blur(radius: 20)
                .offset(x: 170, y: 200)
        }
        .ignoresSafeArea()
    }
}

struct WaterDrop: View {
    let scale: CGFloat
    let offset: CGFloat
    let duration: Double
    @State private var isAnimating = false
    
    var body: some View {
        Image(systemName: "drop.fill")
            .font(.system(size: 24 * scale))
            .foregroundColor(.white.opacity(0.3))
            .offset(y: isAnimating ? offset : -offset)
            .animation(
                Animation.easeInOut(duration: duration)
                    .repeatForever(autoreverses: true),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

struct WaterProgressRing: View {
    let progress: Double
    let goal: Double
    
    var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(Color.white.opacity(0.3), lineWidth: 20)
            
            // Progress ring
            Circle()
                .trim(from: 0, to: CGFloat(min(progress / goal, 1.0)))
                .stroke(
                    LinearGradient(
                        colors: [
                            Color(red: 0.2, green: 0.6, blue: 0.9),
                            Color(red: 0.4, green: 0.7, blue: 1.0)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
            
            // Center content
            VStack(spacing: 4) {
                Text("\(Int(progress))ml")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                Text("of \(Int(goal))ml")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5).opacity(0.8))
            }
        }
    }
}

struct WaterEntryCard: View {
    let amount: Int
    let time: String
    
    var body: some View {
        HStack {
            Image(systemName: "drop.fill")
                .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(amount)ml")
                    .font(.system(.headline, design: .rounded))
                Text(time)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 14, weight: .semibold))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.7))
                .background(.ultraThinMaterial)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

struct QuickAddButton: View {
    let amount: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text("+\(amount)")
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.bold)
                Text("ml")
                    .font(.system(.caption, design: .rounded))
            }
            .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.4))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 0.9, green: 0.95, blue: 1.0))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct MenuCard: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let iconColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(iconColor)
                .font(.system(size: 22, weight: .semibold))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.4))
                    .fontWeight(.bold)
                Text(subtitle)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.4))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.4))
                .font(.system(size: 14, weight: .semibold))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.96, green: 0.96, blue: 0.98))
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct DayCircleView: View {
    let day: String
    let date: Int
    let isActive: Bool
    let hasCompletedWater: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            // Day letter
            Text(day)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(isActive ? Color.black : Color.gray.opacity(0.7))
            
            // Circle with date
            ZStack {
                // Background fill
                Circle()
                    .fill(
                        hasCompletedWater ? 
                            Color(red: 0.95, green: 0.8, blue: 0.2).opacity(0.4) : // Gold for completed days
                            (isActive ? Color.black.opacity(0.08) : Color.gray.opacity(0.08))
                    )
                    .frame(width: 36, height: 36)
                
                // Outline for active day
                if isActive {
                    Circle()
                        .stroke(Color.black, lineWidth: 2)
                        .frame(width: 36, height: 36)
                }
                
                Text("\(date)")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(isActive ? Color.black : Color.gray.opacity(0.7))
            }
        }
    }
}

struct WaterCard: View {
    let progress: Double
    let goal: Double
    
    var percentComplete: Double {
        min(progress / goal, 1.0)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with percentage
            HStack {
                Text("Today's Progress")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(Color(red: 0.4, green: 0.5, blue: 0.6))
                
                Spacer()
                
                Text("\(Int(percentComplete * 100))%")
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
            }
            .padding(.horizontal, 25)
            .padding(.top, 16)
            .padding(.bottom, 8)
            
            // Main content
            HStack(alignment: .center, spacing: 0) {
                // Left side with text
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .lastTextBaseline, spacing: 2) {
                        Text("\(Int(progress))")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                        
                        Text("ml")
                            .font(.system(size: 30, design: .rounded))
                            .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                    }
                    
                    Text("of \(Int(goal))ml goal")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color(red: 0.4, green: 0.5, blue: 0.6))
                }
                .padding(.leading, 25)
                .padding(.bottom, 16)
                .offset(y: -12)
                
                Spacer()
                
                // Progress circle positioned more to the top left
                ZStack {
                    // Background circle
                    Circle()
                        .stroke(Color.gray.opacity(0.15), lineWidth: 12)
                        .frame(width: 110, height: 110)
                    
                    // Progress circle
                    Circle()
                        .trim(from: 0, to: CGFloat(percentComplete))
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.2, green: 0.6, blue: 0.9),
                                    Color(red: 0.4, green: 0.7, blue: 1.0)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: 12, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .frame(width: 110, height: 110)
                        .animation(.easeInOut, value: progress)
                    
                    // Water drop icon
                    Image(systemName: "drop.fill")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                        .offset(y: -2) // Slight adjustment for visual center
                }
                .padding(.trailing, 25)
                .padding(.bottom, 16)
                .offset(x: -20, y: -5) // Move circle more to left and up
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
        )
        .frame(height: 180) // Set a fixed height to compact the card
        .padding(.horizontal)
    }
}

// Add this new struct for the circular dial custom amount selector
struct CustomAmountView: View {
    @Binding var isPresented: Bool
    @Binding var waterAmount: Double
    @State private var dialValue: Double = 45 // Starting with minimum value
    @State private var displayValue: Double = 45 // For displaying exact input value
    @State private var rotationAngle: Double = 0
    @State private var startingAngle: Double = 0
    @State private var showingNumberPad: Bool = false
    @State private var tempInput: String = "45"
    
    let minValue: Double = 45 // Adjusted to be divisible by 15
    let maxValue: Double = 990 // Adjusted to be divisible by 15
    let stepSize: Double = 15 // Value will increment in steps of 15ml
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            HStack {
                Text("Select Amount")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                
                Spacer()
                
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color.gray.opacity(0.7))
                }
            }
            .padding(.horizontal)
            
            // Dial display
            ZStack {
                // Tick marks for increments
                ForEach(0..<66) { index in
                    let angle = Double(index) * (360.0 / 66.0) // 66 steps (990/15) for full circle
                    let isLargerTick = index % 5 == 0 // Larger tick every 75ml (5 steps)
                    
                    Rectangle()
                        .fill(Color(red: 0.2, green: 0.3, blue: 0.5).opacity(isLargerTick ? 0.3 : 0.15))
                        .frame(width: isLargerTick ? 4 : 2, height: isLargerTick ? 12 : 8)
                        .offset(y: -120)
                        .rotationEffect(.degrees(angle))
                }
                
                // Outer track
                Circle()
                    .stroke(Color.gray.opacity(0.15), lineWidth: 30)
                    .frame(width: 240, height: 240)
                
                // Progress track
                Circle()
                    .trim(from: 0, to: CGFloat(min(dialValue / maxValue, 1.0)))
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color(red: 0.2, green: 0.6, blue: 0.9),
                                Color(red: 0.4, green: 0.7, blue: 1.0)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 30, lineCap: .round)
                    )
                    .frame(width: 240, height: 240)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 0.3), value: dialValue)
                
                // Dial knob
                Circle()
                    .fill(Color.white)
                    .frame(width: 40, height: 40)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    .offset(x: 120 * cos(2 * .pi * dialValue / maxValue - .pi / 2),
                            y: 120 * sin(2 * .pi * dialValue / maxValue - .pi / 2))
                    .animation(.easeInOut(duration: 0.3), value: dialValue)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let center = CGPoint(x: 120, y: 120)
                                let point = value.location
                                let angle = atan2(point.y - center.y, point.x - center.x) + .pi / 2
                                let normalizedAngle = angle < 0 ? angle + 2 * .pi : angle
                                let rawValue = (normalizedAngle / (2 * .pi)) * maxValue
                                
                                // Round to nearest step size (15ml)
                                let steppedValue = round(rawValue / stepSize) * stepSize
                                let newValue = min(max(steppedValue, minValue), maxValue)
                                
                                // If value changed to a new step, provide feedback
                                if newValue != dialValue {
                                    dialValue = newValue
                                    displayValue = newValue
                                    tempInput = "\(Int(displayValue))"
                                    
                                    // Provide haptic feedback for the clicky feel
                                    #if os(iOS)
                                    let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                                    impactFeedback.impactOccurred()
                                    #endif
                                }
                            }
                    )
                
                // Value display
                Button(action: {
                    showingNumberPad = true
                }) {
                    VStack {
                        Text("\(Int(displayValue))")
                            .font(.system(size: 52, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                            .animation(.easeInOut(duration: 0.2), value: displayValue)
                        
                        Text("ml")
                            .font(.system(size: 24, design: .rounded))
                            .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.5))
                            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    )
                }
            }
            .frame(width: 240, height: 240)
            .padding()
            
            // Action buttons
            VStack(spacing: 12) {
                // Add button
                Button(action: {
                    waterAmount += displayValue // Use exact input value
                    isPresented = false
                    
                    // Provide haptic feedback
                    #if os(iOS)
                    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                    impactFeedback.impactOccurred()
                    #endif
                }) {
                    Text("Add Water")
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 0.2, green: 0.6, blue: 0.9))
                        )
                }
                
                // Subtract button
                Button(action: {
                    // Prevent negative values
                    if waterAmount >= displayValue {
                        waterAmount -= displayValue // Use exact input value
                    } else {
                        waterAmount = 0
                    }
                    isPresented = false
                    
                    // Provide haptic feedback
                    #if os(iOS)
                    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                    impactFeedback.impactOccurred()
                    #endif
                }) {
                    Text("Subtract Water")
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(Color(red: 0.2, green: 0.6, blue: 0.9), lineWidth: 2)
                        )
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
        .padding(.vertical, 20)
        .sheet(isPresented: $showingNumberPad) {
            NumberPadView(value: $tempInput, onDone: {
                if let newValue = Double(tempInput) {
                    // Store exact input value
                    displayValue = newValue
                    
                    // Round to nearest step size (15ml) for the dial position
                    let steppedValue = round(newValue / stepSize) * stepSize
                    let boundedValue = min(max(steppedValue, minValue), maxValue)
                    
                    withAnimation(.easeInOut(duration: 0.3)) {
                        dialValue = boundedValue
                    }
                    
                    // Provide feedback when value is set
                    #if os(iOS)
                    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                    impactFeedback.impactOccurred()
                    #endif
                }
                showingNumberPad = false
            })
            .presentationDetents([.height(350)])
        }
    }
}

// Number pad view for direct input
struct NumberPadView: View {
    @Binding var value: String
    var onDone: () -> Void
    
    let rows: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["Clear", "0", "Done"]
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Enter Amount (ml)")
                .font(.system(.headline, design: .rounded))
                .padding(.top, 20)
            
            // Value display
            Text(value)
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                )
                .padding(.horizontal, 20)
            
            // Number pad
            VStack(spacing: 8) {
                ForEach(rows, id: \.self) { row in
                    HStack(spacing: 8) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                buttonPressed(button)
                            }) {
                                if button == "Clear" {
                                    Image(systemName: "delete.left")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(Color.gray.opacity(0.15))
                                        .cornerRadius(12)
                                } else if button == "Done" {
                                    Text(button)
                                        .font(.system(.headline, design: .rounded))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(Color(red: 0.2, green: 0.6, blue: 0.9))
                                        .cornerRadius(12)
                                } else {
                                    Text(button)
                                        .font(.system(.title2, design: .rounded))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .background(Color(red: 0.95, green: 0.97, blue: 0.99))
    }
    
    func buttonPressed(_ button: String) {
        #if os(iOS)
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
        #endif
        
        switch button {
        case "Clear":
            if !value.isEmpty {
                value.removeLast()
            }
            if value.isEmpty {
                value = "0"
            }
        case "Done":
            onDone()
        default:
            if value == "0" || value == "00" {
                value = button
            } else if value.count < 4 { // Limit to 4 digits (max 9999ml)
                value += button
            }
        }
    }
}

struct ContentView: View {
    @AppStorage("progress") private var progress: Double = 0
    @AppStorage("goal") private var goal: Double = 2000
    @AppStorage("streakCount") private var streakCount: Int = 0
    @State private var showingCustomSheet = false
    @AppStorage("currentDate") private var currentDateString: String = Date().ISO8601Format()
    @State private var currentDate: Date = Date()
    @State private var completedDays: [String] = [] // Will be loaded from UserDefaults
    @State private var timer: Timer? = nil
    
    // Format date to a unique string key for completed days
    private func dateKey(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    // Get day number from date
    private func dayNumber(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    
    // Get day letter from date
    private func dayLetter(from date: Date) -> String {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        let weekdayLetters = ["S", "M", "T", "W", "T", "F", "S"]
        return weekdayLetters[weekday - 1]
    }
    
    // Returns array of dates for the current week
    private func getCurrentWeekDates() -> [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: currentDate)
        
        // Find the start of the week (Monday)
        var weekday = calendar.component(.weekday, from: today)
        // Convert to 0-indexed where 0 is Monday (calendar uses 1-indexed where 1 is Sunday)
        weekday = weekday == 1 ? 6 : weekday - 2
        
        guard let monday = calendar.date(byAdding: .day, value: -weekday, to: today) else {
            return []
        }
        
        // Create 7 days starting from Monday, allowing proper month transitions
        var weekDates: [Date] = []
        for day in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: day, to: monday) {
                weekDates.append(date)
            }
        }
        
        return weekDates
    }
    
    // Add functions for data persistence
    private func saveCompletedDays() {
        if let encoded = try? JSONEncoder().encode(completedDays) {
            UserDefaults.standard.set(encoded, forKey: "completedDays")
        }
    }
    
    private func loadCompletedDays() {
        if let savedDays = UserDefaults.standard.data(forKey: "completedDays"),
           let decodedDays = try? JSONDecoder().decode([String].self, from: savedDays) {
            completedDays = decodedDays
        }
    }
    
    private func updateCurrentDate() {
        if let date = ISO8601DateFormatter().date(from: currentDateString) {
            currentDate = date
        }
    }
    
    // Modify markDayAsCompleted to save data
    private func markDayAsCompleted() {
        let today = dateKey(from: currentDate)
        if !completedDays.contains(today) {
            completedDays.append(today)
            saveCompletedDays() // Save after modification
            updateStreakCount()
        }
    }
    
    // Update streak count based on completed days
    private func updateStreakCount() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: currentDate)
        let todayString = dateKey(from: today)
        let yesterdayDate = calendar.date(byAdding: .day, value: -1, to: today)!
        let yesterdayString = dateKey(from: yesterdayDate)
        
        // If today is already completed, count today + consecutive previous days
        if completedDays.contains(todayString) {
            var currentStreak = 1 // Start with today
            var checkDate = today
            
            while true {
                // Move to the previous day
                guard let previousDay = calendar.date(byAdding: .day, value: -1, to: checkDate) else {
                    break
                }
                checkDate = previousDay
                
                let checkDateString = dateKey(from: checkDate)
                
                // If this day isn't in our completed days, the streak is broken
                if !completedDays.contains(checkDateString) {
                    break
                }
                
                // Increment streak
                currentStreak += 1
            }
            
            streakCount = currentStreak
        } 
        // If today is not completed but yesterday was, maintain yesterday's streak
        else if completedDays.contains(yesterdayString) {
            // Count consecutive days before yesterday
            var currentStreak = 1 // Start with yesterday
            var checkDate = yesterdayDate
            
            while true {
                // Move to the previous day
                guard let previousDay = calendar.date(byAdding: .day, value: -1, to: checkDate) else {
                    break
                }
                checkDate = previousDay
                
                let checkDateString = dateKey(from: checkDate)
                
                // If this day isn't in our completed days, the streak is broken
                if !completedDays.contains(checkDateString) {
                    break
                }
                
                // Increment streak
                currentStreak += 1
            }
            
            streakCount = currentStreak
        } 
        // If neither today nor yesterday has water, streak is 0
        else {
            streakCount = 0
        }
    }
    
    // Update setupMidnightTimer to handle persistence
    private func setupMidnightTimer() {
        timer?.invalidate()
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.day! += 1
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        guard let midnight = calendar.date(from: components) else { return }
        let timeInterval = midnight.timeIntervalSince(Date())
        
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                if progress > 0 {
                    markDayAsCompleted()
                }
                
                // Update stored date
                let newDate = Date()
                currentDate = newDate
                currentDateString = newDate.ISO8601Format()
                
                // Reset progress for new day
                progress = 0
            }
            
            setupMidnightTimer()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Enhanced background with multi-layer effects
                ZStack {
                    // Base gradient
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.88, green: 0.94, blue: 0.98), // Light blue at top
                            Color(red: 0.85, green: 0.86, blue: 0.96)  // Very subtle purple tint at bottom
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                    // Subtle top-left highlight
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 300, height: 300)
                        .blur(radius: 60)
                        .offset(x: -100, y: -150)
                    
                    // Subtle bottom-right accent
                    Circle()
                        .fill(Color(red: 0.83, green: 0.84, blue: 0.95).opacity(0.2))
                        .frame(width: 250, height: 250)
                        .blur(radius: 50)
                        .offset(x: 150, y: 200)
                }
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // App title and streak badge
                    HStack {
                        // App title - without water drop, using system rounded font
                        Text("AquaTicker")
                            .font(.system(size: 28, weight: .black, design: .rounded))
                            .foregroundColor(.black)
                            .onLongPressGesture(minimumDuration: 2) {
                                // Reset all stored data
                                progress = 0
                                streakCount = 0
                                completedDays = []
                                saveCompletedDays()
                                currentDate = Date()
                                currentDateString = currentDate.ISO8601Format()
                                
                                // Provide haptic feedback
                                #if os(iOS)
                                let notificationFeedback = UINotificationFeedbackGenerator()
                                notificationFeedback.notificationOccurred(.success)
                                #endif
                            }
                        
                        Spacer()
                        
                        // Streak badge
                        HStack(spacing: 4) {
                            Image(systemName: "flame.fill")
                                .foregroundColor(.orange)
                            Text("\(streakCount)")
                                .fontWeight(.bold)
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(
                            Capsule()
                                .fill(Color.white)
                        )
                        .onLongPressGesture(minimumDuration: 2) {
                            // Simulate moving to next day when background is long-pressed
                            withAnimation(.easeInOut(duration: 0.5)) {
                                // If there was water added today, mark the day as completed before advancing
                                if progress > 0 {
                                    markDayAsCompleted()
                                }
                                
                                // Advance to next day and reset progress
                                let calendar = Calendar.current
                                if let tomorrow = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                                    currentDate = tomorrow
                                    currentDateString = tomorrow.ISO8601Format()
                                    progress = 0
                                    
                                    // Explicitly update streak count for the new day
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        updateStreakCount()
                                    }
                                }
                            }
                        }
                        .onTapGesture(count: 2) {
                            // Keep the double-tap functionality as well
                            NotificationCenter.default.post(name: NSNotification.Name("SimulateDayChange"), object: nil)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.bottom, 15)
                    
                    // Dynamic Weekly view with real dates
                    HStack(spacing: 18) {
                        ForEach(getCurrentWeekDates(), id: \.self) { date in
                            let isToday = Calendar.current.isDate(currentDate, inSameDayAs: date)
                            let day = dayLetter(from: date)
                            let dateNum = dayNumber(from: date)
                            let dateString = dateKey(from: date)
                            
                            DayCircleView(
                                day: day,
                                date: dateNum,
                                isActive: isToday,
                                hasCompletedWater: completedDays.contains(dateString)
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .padding(.bottom, 10)
                    
                    // Main content
                    ScrollView {
                        VStack(spacing: 20) {
                            // Water tracking card
                            WaterCard(progress: progress, goal: goal)
                            
                            // Quick Add Buttons
                            VStack(spacing: 16) {
                                HStack(spacing: 16) {
                                    QuickAddButton(amount: 200) {
                                        withAnimation {
                                            progress += 200
                                            markDayAsCompleted()
                                        }
                                    }
                                    
                                    QuickAddButton(amount: 300) {
                                        withAnimation {
                                            progress += 300
                                            markDayAsCompleted()
                                        }
                                    }
                                    
                                    // Custom Amount Button
                                    Button(action: {
                                        showingCustomSheet = true
                                    }) {
                                        VStack {
                                            Text("Custom")
                                                .font(.system(.headline, design: .rounded))
                                                .fontWeight(.bold)
                                            Text("amount")
                                                .font(.system(.caption, design: .rounded))
                                        }
                                        .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.4))
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(Color(red: 0.9, green: 0.95, blue: 1.0))
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                
                                // Photo Button
                                NavigationLink(destination: Text("Log Water Photo").navigationTitle("Log Water Photo")) {
                                    VStack(spacing: 4) {
                                        Text("Take Photo")
                                            .font(.system(.headline, design: .rounded))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.4))
                                        Text("(AI scan)")
                                            .font(.system(.caption, design: .rounded))
                                            .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.4))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color(red: 0.9, green: 0.95, blue: 1.0))
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(false)
                            }
                            .padding(.horizontal)
                            
                            // Menu Options
                            VStack(spacing: 12) {
                                NavigationLink(destination: Text("History View").navigationTitle("History")) {
                                    MenuCard(
                                        title: "History",
                                        subtitle: "View past water intake",
                                        systemImage: "clock.fill",
                                        iconColor: Color(red: 0.4, green: 0.5, blue: 0.9)
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(false)
                                
                                NavigationLink(destination: Text("Statistics View").navigationTitle("Statistics")) {
                                    MenuCard(
                                        title: "Statistics",
                                        subtitle: "Track your progress",
                                        systemImage: "chart.bar.fill",
                                        iconColor: Color(red: 0.3, green: 0.7, blue: 0.9)
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(false)

                                NavigationLink(destination: Text("Reminders").navigationTitle("Set Reminders")) {
                                    MenuCard(
                                        title: "Reminders",
                                        subtitle: "Schedule drinking reminders",
                                        systemImage: "bell.fill",
                                        iconColor: Color(red: 0.9, green: 0.6, blue: 0.3)
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(false)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingCustomSheet) {
            CustomAmountView(isPresented: $showingCustomSheet, waterAmount: $progress)
                .presentationDetents([.height(500)])
                .onDisappear {
                    if progress > 0 {
                        markDayAsCompleted()
                    }
                }
        }
        .preferredColorScheme(.light) // Force light mode
        .onAppear {
            // Load saved data
            loadCompletedDays()
            updateCurrentDate()
            
            // Set up timer for midnight day change
            setupMidnightTimer()
            
            // Update streak count
            updateStreakCount()
            
            // Check if we need to reset progress (if it's a new day)
            let calendar = Calendar.current
            if !calendar.isDate(currentDate, inSameDayAs: Date()) {
                progress = 0
                currentDate = Date()
                currentDateString = currentDate.ISO8601Format()
            }
            
            // For testing only - allow testing day change by double-tapping the streak counter
            NotificationCenter.default.addObserver(forName: NSNotification.Name("SimulateDayChange"), object: nil, queue: .main) { _ in
                withAnimation(.easeInOut(duration: 0.5)) {
                    if progress > 0 {
                        markDayAsCompleted()
                    }
                    
                    let calendar = Calendar.current
                    if let tomorrow = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                        currentDate = tomorrow
                        currentDateString = tomorrow.ISO8601Format()
                        progress = 0
                        updateStreakCount()
                    }
                }
            }
        }
        .onDisappear {
            // Save any pending changes
            saveCompletedDays()
            
            // Clean up timer
            timer?.invalidate()
            timer = nil
        }
    }
}

#Preview {
    ContentView()
}
