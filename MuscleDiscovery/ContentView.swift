//
//  ContentView.swift
//  MuscleDiscovery
//
//  Created by Thuc on 12/9/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var showingMainView: Bool = false
    
    var body: some View {
        Group {
            if showingMainView {
                SessionCheckView()
            }
            else {
                AnimatedSplashView(showingMainView: self.$showingMainView)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
