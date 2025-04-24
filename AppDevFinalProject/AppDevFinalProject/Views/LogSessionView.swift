//
//  LogSessionView.swift
//  AppDevFinalProject
//
//  Created by Amari Battle on 4/23/25.
//

import SwiftUI             // UI layout and views
import PhotosUI            // For photo picker
import CoreLocation        // For logging location
import Firebase            // Base Firebase functionality
import FirebaseStorage     // To upload image to Firebase Storage


struct LogSessionView: View {
    let duration: Int
    let completedTasks: [UserTask]

    @Environment(\.dismiss) var dismiss
    @State private var notes = ""
    @State private var location: CLLocationCoordinate2D?
    @State private var selectedImage: UIImage?
    @State private var showPhotoPicker = false
    @StateObject private var locationManager = LocationManager()
    @State private var photoPickerItem: PhotosPickerItem?

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("🎉 Focus Session Complete!")
                    .font(.title)
                    .bold()

                TextField("Add a quick note...", text: $notes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Add Photo") {
                    showPhotoPicker = true
                }

                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .cornerRadius(12)
                }

                Button("Save Session") {
                    let geoPoint = location != nil ? GeoPoint(latitude: location!.latitude, longitude: location!.longitude) : nil
                    let taskTitles = completedTasks.map { $0.title }

                    uploadImage(selectedImage) { imageUrl in
                        let session = Session(
                            duration: duration,
                            timestamp: Date(),
                            notes: notes,
                            photoUrl: imageUrl,
                            location: geoPoint,
                            tasksCompleted: taskTitles
                        )
                        FirebaseService.shared.saveSession(session)
                        dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)

                Button("Dismiss") {
                    dismiss()
                }
                .foregroundColor(.gray)

                Spacer()
            }
            .padding()
            .navigationTitle("Log Session")
            .onAppear {
                locationManager.requestLocation()
                location = locationManager.lastKnownLocation
            }
            .photosPicker(isPresented: $showPhotoPicker, selection: $photoPickerItem, matching: .images)
            .onChange(of: photoPickerItem) {
                Task {
                    if let data = try? await photoPickerItem?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        selectedImage = image
                    }
                }
            }

        }
    }

    func uploadImage(_ image: UIImage?, completion: @escaping (String?) -> Void) {
        guard let image = image, let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }

        let storageRef = Storage.storage().reference().child("sessionImages/\(UUID().uuidString).jpg")
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil)
                return
            }

            storageRef.downloadURL { url, _ in
                completion(url?.absoluteString)
            }
        }
    }
}
