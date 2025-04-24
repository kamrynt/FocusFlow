//
//  TodayView.swift
//  AppDevFinalProject
//
//  Created by Amari Battle on 4/23/25.
//

import SwiftUI

struct TodayView: View {
    @State private var showTimer = false
    @State private var completedTasks: [UserTask] = []

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Today's Tasks")
                    .font(.title2)
                    .fontWeight(.bold)

                TaskListView(onCompleted: { tasks in
                    self.completedTasks = tasks
                })

                Spacer()

                Button("Start Focus Session") {
                    showTimer = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.teal)
                .foregroundColor(.white)
                .cornerRadius(12)

                Text("🧠 \"Discipline is choosing between what you want now and what you want most.\"")
                    .font(.footnote)
                    .foregroundColor(.gray)

                Spacer()
            }
            .padding()
            .navigationTitle("Today")
            .sheet(isPresented: $showTimer) {
                FocusTimerView(completedTasks: completedTasks)
            }
        }
    }
}
