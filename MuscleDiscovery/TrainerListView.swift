//
//  TrainerListView.swift
//  MuscleDiscovery
//
//  Created by Thuc on 12/9/2023.
//

import SwiftUI

struct TrainerListView: View {
    // Bind presentation mode of DetailView to  the PokeListView and will be used by the custome back button to dismiss the view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var trainerViewModel = TrainerViewModel()
    
    @Binding var showing: Bool
    
    var backButton: some View {
        Button(action: {
            withAnimation() {
                self.presentationMode.wrappedValue.dismiss()
            }
        })  {
            Circle()
                .fill(ColorConstant.gray)
                .frame(height: 30)
                .overlay(alignment: .center, content: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                    
                })
                .foregroundColor(.black)
                .shadow(color: Color("BlackTransparent"), radius: 7)
        }
        .contentShape(Circle())
        .padding(.trailing, 20)
    }
    
    var body: some View {
        // MARK: Main VStack
        VStack {
            // MARK: Main List
            List {
                // MARK: ForEach through each trainer in list
                ForEach(trainerViewModel.trainerList) {trainer in
                    ZStack {
                        TrainerRow(trainer: trainer)
                            .frame(maxWidth: .infinity)
//                        Button {
//                            print("Entered")
//                            path.append(2)
//                        } label: {
//                            TrainerRow(trainer: trainer)
//                                .frame(maxWidth: .infinity)
//                        }
//                        .navigationDestination(for: Int.self) { int in
//                            TrainerDetailView(path: $path, trainer: trainer)
//                        }
                        
                        NavigationLink(destination: TrainerDetailView(trainer: trainer, showing: self.$showing)) {

                        }
                        .opacity(0)
                    }
                    
                } // end ForEach through each trainer in list
                .listRowBackground(ColorConstant.black)
                
            } // end Main List
            .listStyle(PlainListStyle())
            .background(ColorConstant.black)
            
        } // end Main VStack
        .background(ColorConstant.black)
        // MARK: Hide default Back Button
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack (spacing: 20) {
                    backButton

                    Text("FITNESS TRAINERS")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .heavy))
                }
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
            }

        }
        
    }
}
