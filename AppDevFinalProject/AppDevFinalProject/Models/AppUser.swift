//
//  User.swift
//  AppDevFinalProject
//
//  Created by Amari Battle on 4/23/25.
//

import Foundation

struct AppUser: Identifiable, Codable {
    var id: String // user ID from Firebase Auth
    var email: String
    var displayName: String
}

