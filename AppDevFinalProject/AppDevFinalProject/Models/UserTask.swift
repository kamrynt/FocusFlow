//
//  Task.swift
//  AppDevFinalProject
//
//  Created by Amari Battle on 4/23/25.
//

import Foundation
import FirebaseFirestore


struct UserTask: Identifiable, Codable, Equatable {
    @DocumentID var id: String? = UUID().uuidString
    var title: String
    var isCompleted: Bool
    var createdAt: Date
}
