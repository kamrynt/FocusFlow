//
//  MapView.swift
//  AppDevFinalProject
//
//  Created by Amari Battle on 4/23/25.
//

import SwiftUI
import MapKit
import FirebaseFirestore


struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 38.9072, longitude: -77.0369), // Default: DC
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    @State private var sessionLocations: [Session] = []

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: sessionLocations) { session in
            MapPin(coordinate: CLLocationCoordinate2D(
                latitude: session.location?.latitude ?? 0,
                longitude: session.location?.longitude ?? 0
            ))
        }
        .onAppear {
            FirebaseService.shared.fetchSessions { sessions in
                self.sessionLocations = sessions.filter { $0.location != nil }
            }
        }
        .navigationTitle("Focus Spots")
    }
}

