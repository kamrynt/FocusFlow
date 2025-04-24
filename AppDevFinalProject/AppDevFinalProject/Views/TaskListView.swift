//
//  TaskListView.swift
//  AppDevFinalProject
//
//  Created by Amari Battle on 4/23/25.
//

import Foundation
import SwiftUI

struct TaskListView: View {
    var onCompleted: (([UserTask]) -> Void)? = nil
    @State private var newTaskTitle = ""
    @State private var tasks: [UserTask] = []

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                TextField("Add new task...", text: $newTaskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Add") {
                    let task = UserTask(title: newTaskTitle, isCompleted: false, createdAt: Date())
                    FirebaseService.shared.saveTask(task)
                    newTaskTitle = ""
                }
            }

            List {
                ForEach(tasks) { task in
                    HStack {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                var updatedTask = task
                                updatedTask.isCompleted.toggle()
                                FirebaseService.shared.updateTask(updatedTask)
                            }
                        Text(task.title)
                            .strikethrough(task.isCompleted)
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { i in
                        FirebaseService.shared.deleteTask(tasks[i])
                    }
                }
            }
        }
        .padding()
        .onAppear {
            FirebaseService.shared.fetchTasks { fetched in
                self.tasks = fetched
                onCompleted?(fetched.filter { $0.isCompleted })
            }
        }
        .onChange(of: tasks) {
            onCompleted?(tasks.filter { $0.isCompleted })
        }

    }
}
