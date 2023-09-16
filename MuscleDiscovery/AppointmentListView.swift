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
                
                List {
                    ForEach(appointmentViewModel.userAppointments) {appointment in
                        ZStack {
                            AppointmentRow(appointment: appointment)
                            
                            NavigationLink(destination: AppointmentDetailView(appointent: appointment)) {

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
                
                Button {
                    showing = true
                } label: {
                    Text("New Appointment")
                        .font(.system(size: 14, weight: .semibold))
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
                
            }
            
        } // end Main NavigationView
        .environmentObject(appointmentViewModel)
    }
}

struct AppointmentListView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentListView()
    }
}
