//
//  MuscleDiscoveryApp.swift
//  MuscleDiscovery
//
//  Created by Thuc on 12/9/2023.
//

import SwiftUI
import Firebase

@main
struct MuscleDiscoveryApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
