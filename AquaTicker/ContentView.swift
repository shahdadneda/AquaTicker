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
                .fill(Color.white.opacity(0.2))
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
                Text("ml")
                    .font(.system(.caption, design: .rounded))
            }
            .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
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
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(.headline, design: .rounded))
                Text(subtitle)
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

struct ContentView: View {
    @State private var progress: Double = 750
    @State private var goal: Double = 2000
    @State private var showingCustomSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Progress Ring
                        WaterProgressRing(progress: progress, goal: goal)
                            .frame(height: 200)
                            .padding(.top, 20)
                        
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
                                        Text("amount")
                                            .font(.system(.caption, design: .rounded))
                                    }
                                    .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(.ultraThinMaterial)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            
                            // Photo Button
                            NavigationLink(destination: Text("Log Water Photo")) {
                                HStack {
                                    Image(systemName: "camera.fill")
                                        .font(.system(.headline))
                                    VStack(spacing: 4) {
                                        Text("Take Photo")
                                            .font(.system(.headline, design: .rounded))
                                        Text("(AI scan)")
                                            .font(.system(.caption, design: .rounded))
                                    }
                                }
                                .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.ultraThinMaterial)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 24)
                        
                        // Menu Options
                        VStack(spacing: 12) {
                            NavigationLink(destination: Text("History")) {
                                MenuCard(
                                    title: "History",
                                    subtitle: "View past water intake",
                                    systemImage: "clock.fill",
                                    iconColor: Color(red: 0.4, green: 0.5, blue: 0.9)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(destination: Text("Statistics")) {
                                MenuCard(
                                    title: "Statistics",
                                    subtitle: "Track your progress",
                                    systemImage: "chart.bar.fill",
                                    iconColor: Color(red: 0.3, green: 0.7, blue: 0.9)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())

                            NavigationLink(destination: Text("Set Reminders")) {
                                MenuCard(
                                    title: "Reminders",
                                    subtitle: "Schedule drinking reminders",
                                    systemImage: "bell.fill",
                                    iconColor: Color(red: 0.9, green: 0.6, blue: 0.3)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("AquaTicker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("AquaTicker")
                        .font(.system(size: 24, weight: .black, design: .rounded))
                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "gear")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.5))
                    }
                }
            }
            .sheet(isPresented: $showingCustomSheet) {
                // Custom amount sheet will go here
                Text("Custom Amount")
                    .presentationDetents([.height(300)])
            }
        }
    }
}

#Preview {
    ContentView()
}
