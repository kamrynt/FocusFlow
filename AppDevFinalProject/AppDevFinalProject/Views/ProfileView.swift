//
//  ProfileView.swift
//  AppDevFinalProject
//
//  Created by Amari Battle on 4/23/25.
//

import SwiftUI

import FirebaseAuth

struct ProfileView: View {
    @Binding var isUserSignedIn: Bool
    @StateObject private var firebaseService = FirebaseService.shared
    @State private var streakCount = 0
    @State private var totalSessions = 0

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)

            Text("Welcome!")
                .font(.title2)
                .fontWeight(.medium)

            VStack(spacing: 12) {
                HStack {
                    Text("Session Streak")
                    Spacer()
                    Text("\(streakCount) 🔥")
                        .fontWeight(.semibold)
                }

                HStack {
                    Text("Total Sessions")
                    Spacer()
                    Text("\(totalSessions) 📍")
                        .fontWeight(.semibold)
                }
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)

            Spacer()

            Button("Sign Out") {
                do {
                    try Auth.auth().signOut()
                    isUserSignedIn = false // ✅ Trigger switch to SignInView
                } catch {
                    print("Failed to sign out: \(error.localizedDescription)")
                }
            }
        }
        .padding()
        .onAppear {
            fetchStats()
        }
    }

    private func fetchStats() {
        firebaseService.fetchSessions { sessions in
            totalSessions = sessions.count

            // Optional: Simple streak logic
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            let recentDates = sessions.map { calendar.startOfDay(for: $0.timestamp) }

            let streak = (0..<7).prefix { offset in
                let date = calendar.date(byAdding: .day, value: -offset, to: today)!
                return recentDates.contains(date)
            }

            streakCount = streak.count
        }
    }
}

