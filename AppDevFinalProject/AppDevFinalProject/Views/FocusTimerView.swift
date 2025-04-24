//
//  FocusTimerView.swift
//  AppDevFinalProject
//
//  Created by Amari Battle on 4/23/25.
//

import SwiftUI
import AVFoundation
import CoreLocation
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseFirestore


struct FocusTimerView: View {
    var completedTasks: [UserTask] = []

    @State private var timeRemaining = 25 * 60
    @State private var timerRunning = false
    @State private var timer: Timer?
    @State private var showLogScreen = false
    @State private var progress: CGFloat = 1.0

    let totalTime = 25 * 60

    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Circle()
                    .stroke(lineWidth: 16)
                    .opacity(0.2)
                    .foregroundColor(.blue)

                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.linear(duration: 1.0), value: progress)

                Text(timeString())
                    .font(.system(size: 36, weight: .bold, design: .monospaced))
            }
            .frame(width: 200, height: 200)

            HStack(spacing: 20) {
                Button(timerRunning ? "Pause" : "Start") {
                    timerRunning ? pauseTimer() : startTimer()
                }
                .buttonStyle(.borderedProminent)

                Button("Reset") {
                    resetTimer()
                }
                .buttonStyle(.bordered)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Focus Timer")
        .sheet(isPresented: $showLogScreen) {
            LogSessionView(duration: (totalTime - timeRemaining) / 60, completedTasks: completedTasks)
        }
    }

    func timeString() -> String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func startTimer() {
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
                progress = CGFloat(timeRemaining) / CGFloat(totalTime)
            } else {
                completeSession()
            }
        }
    }

    func pauseTimer() {
        timer?.invalidate()
        timerRunning = false
    }

    func resetTimer() {
        timer?.invalidate()
        timeRemaining = totalTime
        progress = 1.0
        timerRunning = false
    }

    func completeSession() {
        timer?.invalidate()
        timerRunning = false
        playSound()
        showLogScreen = true
    }

    func playSound() {
        AudioServicesPlaySystemSound(1052)
    }
}
