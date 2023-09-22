//
//  SessionCheckView.swift
//  MuscleDiscovery
//
//  Created by Trí Lai on 18/09/2023.
//

import SwiftUI

struct SessionCheckView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isLoading = false
    
    var body: some View {
        if viewModel.isLoggedIn {
            MainMenuView()
        } else {
            LoginView()
        }
    }
}

struct SessionCheckView_Previews: PreviewProvider {
    static var previews: some View {
        SessionCheckView()
    }
}
