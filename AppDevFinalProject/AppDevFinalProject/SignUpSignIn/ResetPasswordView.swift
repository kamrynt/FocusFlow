//
//  ResetPasswordView.swift
//  AppDevFinalProject
//
//  Created by Amari Battle on 4/23/25.
//

import SwiftUI
import FirebaseAuth

struct ResetPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var message = ""
    @State private var isError = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Reset Password")
                    .font(.title2)

                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)

                Button("Send Reset Link") {
                    sendResetLink()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                if !message.isEmpty {
                    Text(message)
                        .font(.footnote)
                        .foregroundColor(isError ? .red : .green)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Forgot Password?")
        }
    }

    private func sendResetLink() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                message = "Error: \(error.localizedDescription)"
                isError = true
            } else {
                message = "✅ Reset email sent! Check your inbox."
                isError = false
            }
        }
    }
}
