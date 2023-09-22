//
//  MainMenuView.swift
//  MuscleDiscovery
//
//  Created by Thuc on 22/9/2023.
//

import SwiftUI

struct MainMenuView: View {
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
        }
        .toolbarColorScheme(.light, for: .tabBar)
        .navigationBarBackButtonHidden(true)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
