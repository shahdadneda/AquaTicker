//
//  ContentView.swift
//  AquaTicker
//
//  Created by Shahdad Neda on 2025-03-26.
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
                .fill(Color(red: 0.9, green: 0.95, blue: 1.0))
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct DayCircleView: View {
    let day: String
    let date: Int
    let isActive: Bool
    
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
                    .fill(isActive ? 
                          Color.black.opacity(0.08) : 
                          Color.gray.opacity(0.08))
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

struct WeeklyViewRow: View {
    @Binding var currentDay: Int
    
    var body: some View {
        HStack(spacing: 18) {
            DayCircleView(day: "F", date: 21, isActive: currentDay == 21)
            DayCircleView(day: "S", date: 22, isActive: currentDay == 22)
            DayCircleView(day: "S", date: 23, isActive: currentDay == 23)
            DayCircleView(day: "M", date: 24, isActive: currentDay == 24)
            DayCircleView(day: "T", date: 25, isActive: currentDay == 25)
            DayCircleView(day: "W", date: 26, isActive: currentDay == 26)
            DayCircleView(day: "T", date: 27, isActive: currentDay == 27)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
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
    @State private var progress: Double = 0
    @State private var goal: Double = 2000
    @State private var showingCustomSheet = false
    @State private var currentDay: Int = 26 // Today is day 26
    
    var body: some View {
        NavigationView {
            ZStack {
                // Light blue background - "Crumbl Blue" style
                Color(red: 0.85, green: 0.92, blue: 0.98)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // App title and streak badge
                    HStack {
                        // App title - without water drop, using system rounded font
                        Text("AquaTicker")
                            .font(.system(size: 28, weight: .black, design: .rounded))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        // Streak badge
                        HStack(spacing: 4) {
                            Image(systemName: "flame.fill")
                                .foregroundColor(.orange)
                            Text("0")
                                .fontWeight(.bold)
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(
                            Capsule()
                                .fill(Color.white)
                        )
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.bottom, 15)
                    
                    // Weekly view
                    WeeklyViewRow(currentDay: $currentDay)
                        .padding(.bottom, 20)
                    
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
                                        }
                                    }
                                    
                                    QuickAddButton(amount: 300) {
                                        withAnimation {
                                            progress += 300
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
                                    HStack {
                                        Image(systemName: "camera.fill")
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.4))
                                        VStack(spacing: 4) {
                                            Text("Take Photo")
                                                .font(.system(.headline, design: .rounded))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.4))
                                            Text("(AI scan)")
                                                .font(.system(.caption, design: .rounded))
                                                .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.4))
                                        }
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
        }
    }
}

#Preview {
    ContentView()
}
