//
//  AppointmentListView.swift
//  MuscleDiscovery
//
//  Created by Thuc on 13/9/2023.
//

import SwiftUI

struct AppointmentListView: View {
    @StateObject var appointmentViewModel = AppointmentViewModel(customerID: "729ZaGcDAd29nCk8pEU4")
    
    @State var showing: Bool = false
    
    var body: some View {
        // MARK: Main NavigationView
        NavigationStack {
            ZStack {
                ColorConstant.black
                    .edgesIgnoringSafeArea(.all)
                
                // MARK: VStack for list
                VStack {
                    Text("UPCOMING APPOINTMENTS")
                        .foregroundColor(.white)
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
                            }
                            .onAppear {
                                self.appointmentViewModel.sortByDate()
                            }
                            .listRowBackground(ColorConstant.black)
                        }
                        .listStyle(PlainListStyle())
                        .background(ColorConstant.black)
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
                            .fill(ColorConstant.luminousGreen)
                            .cornerRadius(25)
                            .frame(width: UIScreen.main.bounds.width*0.7)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .shadow(color: .white.opacity(0.4), radius: 4)
                        )
                }
                .frame(maxHeight: UIScreen.main.bounds.height, alignment: .bottom)
                .navigationDestination(isPresented: $showing) {
                    TrainerListView(showing: self.$showing)
                }
                
            } // end ZStack
            
        } // end Main NavigationView
        .environmentObject(appointmentViewModel)
    }
}

struct AppointmentListView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentListView()
    }
}
