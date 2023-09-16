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
    @StateObject var viewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            VideoCallView()
//            SplashView()
//                .environmentObject(viewModel)
        }
    }
}
