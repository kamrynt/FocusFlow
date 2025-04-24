//
//  FocusFlowAppView.swift
//  AppDevFinalProject
//
//  Created by Amari Battle on 4/23/25.
//

import SwiftUI
import FirebaseAuth


struct FocusFlowAppView: View {
    @State private var isUserSignedIn: Bool = Auth.auth().currentUser != nil
    @State private var showSignUp = false
    @State private var showReset = false

    var body: some View {
        if isUserSignedIn {
            TabView {
                TodayView()
                    .tabItem { Label("Today", systemImage: "checkmark.circle") }

                FocusTimerView()
                    .tabItem { Label("Focus", systemImage: "timer") }

                MapView()
                    .tabItem { Label("Map", systemImage: "map") }

                ProfileView(isUserSignedIn: $isUserSignedIn)
                    .tabItem { Label("Profile", systemImage: "person.circle") }
            }
        } else {
            SignInView(
                onSignIn: { self.isUserSignedIn = true },
                onShowSignUp: { self.showSignUp = true },
                onShowReset: { self.showReset = true }
            )
            .sheet(isPresented: $showSignUp) {
                SignUpView {
                    self.showSignUp = false
                    self.isUserSignedIn = true
                }
            }
            .sheet(isPresented: $showReset) {
                ResetPasswordView()
            }
        }
    }
}
