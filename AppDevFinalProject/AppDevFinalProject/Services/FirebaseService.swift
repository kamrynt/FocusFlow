//
//  FirebaseService.swift
//  AppDevFinalProject
//
//  Created by Amari Battle on 4/23/25.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth


class FirebaseService: ObservableObject{
    static let shared = FirebaseService()
    private init() {}

    private let db = Firestore.firestore()

    var userId: String {
        Auth.auth().currentUser?.uid ?? "anonymous"
    }

    // Write Session
    func saveSession(_ session: Session, completion: ((Error?) -> Void)? = nil) {
        do {
            let ref = db.collection("users").document(userId)
                        .collection("sessions").document(session.id ?? UUID().uuidString)
            try ref.setData(from: session, completion: completion)
        } catch {
            completion?(error)
        }
    }

    // Read Sessions
    func fetchSessions(completion: @escaping ([Session]) -> Void) {
        db.collection("users").document(userId)
          .collection("sessions")
          .order(by: "timestamp", descending: true)
          .getDocuments { snapshot, error in
              if let snapshot = snapshot {
                  let sessions = snapshot.documents.compactMap {
                      try? $0.data(as: Session.self)
                  }
                  completion(sessions)
              } else {
                  print("Error fetching sessions: \(error?.localizedDescription ?? "")")
                  completion([])
              }
          }
    }
    
    //Write Task
    func saveTask(_ task: UserTask, completion: ((Error?) -> Void)? = nil) {
        do {
            let ref = db.collection("users").document(userId)
                        .collection("tasks").document(task.id ?? UUID().uuidString)
            try ref.setData(from: task, completion: completion)
        } catch {
            completion?(error)
        }
    }

    //Update Task
    func updateTask(_ task: UserTask, completion: ((Error?) -> Void)? = nil) {
        saveTask(task, completion: completion)
    }

    //Delete Task
    func deleteTask(_ task: UserTask, completion: ((Error?) -> Void)? = nil) {
        guard let taskId = task.id else { return }
        db.collection("users").document(userId)
          .collection("tasks").document(taskId)
          .delete(completion: completion)
    }

    //Read Tasks
    func fetchTasks(completion: @escaping ([UserTask]) -> Void) {
        db.collection("users").document(userId)
          .collection("tasks")
          .order(by: "createdAt", descending: true)
          .addSnapshotListener { snapshot, error in
              if let snapshot = snapshot {
                  let tasks = snapshot.documents.compactMap {
                      try? $0.data(as: UserTask.self)
                  }
                  completion(tasks)
              } else {
                  print("Error fetching tasks: \(error?.localizedDescription ?? "")")
                  completion([])
              }
          }
    }

}

