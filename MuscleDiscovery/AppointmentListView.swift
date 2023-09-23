//
//  AppointmentListView.swift
//  MuscleDiscovery
//
//  Created by Thuc on 13/9/2023.
//

import SwiftUI

struct AppointmentListView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
    @StateObject var appointmentViewModel: AppointmentViewModel
    
    init(userID: String) {
        _appointmentViewModel = StateObject(wrappedValue: AppointmentViewModel(customerID: userID))
    }
    
    @State var showing: Bool = false
    
    var body: some View {
        // MARK: Main NavigationView
        NavigationStack {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
                // MARK: VStack for list
                VStack {
                    Text("UPCOMING APPOINTMENTS")
                        .font(.title2)
                        .fontWeight(.heavy)
                    
                    // If there is atleast 1 appointment
                    if (appointmentViewModel.userAppointments.count > 0) {
                        List {
                            ForEach(appointmentViewModel.userAppointments) {appointment in
                                ZStack {
                                    AppointmentRow(appointment: appointment)
                                    
                                    NavigationLink(destination: AppointmentDetailView(appointment: appointment)) {

                                    }
                                    .opacity(0)
                                }
                                .listRowSeparator(.hidden)
                            }
                            .onAppear {
                                self.appointmentViewModel.sortByDate()
                            }
                            .listRowBackground(Color("Background"))
                        }
                        .listStyle(PlainListStyle())
                        .background( Color("Background"))
                        .padding(.top)
                    }
                    else {
                        Spacer()
                        
                        Text("No Upcoming Appointment.")
                            .font(.headline)
                            .foregroundColor(ColorConstant.textGray)
                    }
                    
                    Spacer()
                } // end VStack for list
                .frame(maxHeight: UIScreen.main.bounds.height, alignment: .top)
                
                Button {
                    showing = true
                } label: {
                    Text("New Appointment")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .background(
                            Rectangle()
                            .fill(Color("Neon"))
                            .cornerRadius(25)
                            .frame(width: UIScreen.main.bounds.width*0.7)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .shadow(color: .white.opacity(0.4), radius: 4)
                        )
                }
                .frame(maxHeight: UIScreen.main.bounds.height, alignment: .bottom)
                .padding(.bottom)
                .navigationDestination(isPresented: $showing) {
                    TrainerListView(showing: self.$showing)
                }
                .modifier(Shadown3DModifier())
                
            } // end ZStack
            
        } // end Main NavigationView
        .environmentObject(appointmentViewModel)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
