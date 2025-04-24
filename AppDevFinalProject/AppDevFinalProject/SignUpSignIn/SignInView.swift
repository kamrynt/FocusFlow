//
//  SignInView.swift
//  AppDevFinalProject
//
//  Created by Amari Battle on 4/23/25.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    var onSignIn: () -> Void
    var onShowSignUp: () -> Void
    var onShowReset: () -> Void

    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Sign In").font(.largeTitle).fontWeight(.semibold)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button("Sign In") {
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    if let error = error {
                        errorMessage = error.localizedDescription
                    } else {
                        onSignIn()
                    }
                }
            }
            .buttonStyle(.borderedProminent)

            Button("Forgot Password?", action: onShowReset)
                .font(.footnote)

            Button("Don't have an account? Sign Up", action: onShowSignUp)
                .font(.footnote)

            Spacer()
        }
        .padding()
    }
}
