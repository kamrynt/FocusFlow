//
//  AppDevFinalProjectApp.swift
//  AppDevFinalProject
//
//  Created by Kamryn Tate on 4/7/25.
//

import SwiftUI

@main
struct AppDevFinalProjectApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            FocusFlowAppView()
        }
    }
}

