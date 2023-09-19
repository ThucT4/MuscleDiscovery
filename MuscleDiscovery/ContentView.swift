//
//  ContentView.swift
//  MuscleDiscovery
//
//  Created by Thuc on 12/9/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AppointmentListView()
                .tabItem{
                    Label("Trainers", systemImage: "figure.strengthtraining.traditional")
                }
            
            FoodAnalysisView()
                .tabItem {
                    Label("Nutrition", systemImage: "chart.pie.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
            
            EmptyView()
                .tabItem{
                    Label("Home", systemImage: "person")
                }
            
        }
        .toolbarColorScheme(.light, for: .tabBar)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
