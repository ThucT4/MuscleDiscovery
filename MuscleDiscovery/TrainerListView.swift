//
//  TrainerListView.swift
//  MuscleDiscovery
//
//  Created by Thuc on 12/9/2023.
//

import SwiftUI

struct TrainerListView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
    // Bind presentation mode of DetailView to  the PokeListView and will be used by the custome back button to dismiss the view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var trainerViewModel = TrainerViewModel()
    
    @Binding var showing: Bool
    
    @State var searchText: String = ""
    
    var backButton: some View {
        Button(action: {
            withAnimation() {
                self.presentationMode.wrappedValue.dismiss()
            }
        })  {
            Circle()
                .fill(Color("Dark grey"))
                .frame(height: 30)
                .overlay(alignment: .center, content: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(isDarkMode ? .white : .black)
                    
                })
                .modifier(Shadown3DModifier())
        }
        .contentShape(Circle())
    }
    
    var body: some View {
        NavigationView {
            // MARK: Main VStack
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                
                VStack {
                    DropDownMenu()
                        .modifier(Shadown3DModifier())
                        .frame(maxWidth: UIScreen.main.bounds.width*0.9, alignment: .trailing)
                    
                    // MARK: Main List
                    List {
                        // MARK: ForEach through each trainer in list
                        ForEach(trainerViewModel.trainerList) {trainer in
                            ZStack {
                                TrainerRow(trainer: trainer)
                                    .modifier(Shadown3DModifier())
                                    .frame(maxWidth: .infinity)
                                
                                NavigationLink(destination: TrainerDetailView(trainer: trainer, showing: self.$showing)) {
                                        
                                }
                                .opacity(0)
                            }
                            .listRowBackground(Color("Background"))
                            .listRowSeparator(.hidden)

                        } // end ForEach through each trainer in list
                    } // end Main List
                    .listStyle(PlainListStyle())
                    .onChange(of: self.searchText) {newValue in
                        self.trainerViewModel.getAllTrainerData(searchName: self.searchText)
                    }
                }
                
                
                
            } // end Main List
        }
        // MARK: Hide default Back Button
        .searchable(text: self.$searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Trainer by Name")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack (spacing: 20) {
                    backButton

                    Text("FITNESS TRAINERS")
                        .font(.title2)
                        .fontWeight(.heavy)
                }
            }

        }
        .environmentObject(trainerViewModel)
        
    }
}
