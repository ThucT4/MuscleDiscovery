//
//  AppointmentListView.swift
//  MuscleDiscovery
//
//  Created by Thuc on 13/9/2023.
//

import SwiftUI

struct AppointmentListView: View {
    @StateObject var appointmentViewModel = AppointmentViewModel(customerID: "729ZaGcDAd29nCk8pEU4")
    
    static let dateTimeFormatter1: DateFormatter = {
        let formartter = DateFormatter()
        
        formartter.dateFormat = "EEE d MMM yyyy"
        
        return formartter
    }()
    
    static let dateTimeFormatter2: DateFormatter = {
        let formartter = DateFormatter()
        
        formartter.dateFormat = "HH:mm"
        
        return formartter
    }()
    
    @State var showing: Bool = false
    
    var body: some View {
        // MARK: Main NavigationView
        NavigationStack {
            ZStack {
                ColorConstant.black
                    .edgesIgnoringSafeArea(.all)
                
                List {
                    ForEach(appointmentViewModel.userAppointments) {appointment in
                        HStack {
                            Text("\(appointment.date!, formatter: Self.dateTimeFormatter1)")
                                .font(.system(size: 12, weight: .bold))
                                .multilineTextAlignment(.center)
                                .frame(width: UIScreen.main.bounds.width*0.15)
                                .foregroundColor(.white)
                            
                            // MARK: Main HStack
                            HStack {
                                // Circle to take space while waiting for image loading
                                Circle()
                                    .fill(ColorConstant.gray)
                                    .frame(width: 70)
                                    .overlay(alignment: .center, content: {
                                        AsyncImage(url: URL(string: appointment.trainer!.imageURL ?? "")!) {image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(Circle())
                                                .frame(width: 70)
                                        } placeholder: {

                                        }
                                    })
                                    .padding()
                                
                                VStack {
                                    HStack (spacing: 5) {
                                        Text(appointment.trainer!.name!)
                                            .font(.system(size: 18, weight: .semibold))
                                        
                                        Text("\(appointment.trainer!.rating!.clean)")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.black)
                                            .padding(4)
                                            .background(
                                                Rectangle()
                                                    .fill(ColorConstant.luminousGreen)
                                                    .cornerRadius(5)
                                            )
                                        
                                        Spacer()
                                        
                                    }
                                    .foregroundColor(.white)
                                    
                                    Text("\(appointment.date!, formatter: Self.dateTimeFormatter2)")
                                        .font(.system(size: 14, weight: .bold))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                
                                Spacer()
                                
                            } // end Main HStack
                            .background(ColorConstant.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
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
