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
        Group {
            if viewModel.userSession != nil {
                ContentView()
                    .navigationBarBackButtonHidden(true)
            } else {
                LoginView()
            }
        }
    }
    
    private func delay() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        isLoading.toggle()
    }
}

struct SessionCheckView_Previews: PreviewProvider {
    static var previews: some View {
        SessionCheckView()
    }
}
