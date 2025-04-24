//
//  Session.swift
//  AppDevFinalProject
//
//  Created by Amari Battle on 4/23/25.
//

import Foundation
import FirebaseFirestore
import CoreLocation

struct Session: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var duration: Int
    var timestamp: Date
    var notes: String?
    var photoUrl: String?
    var location: GeoPoint?
    var tasksCompleted: [String] = []
}


