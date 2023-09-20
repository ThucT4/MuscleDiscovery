//
//  AppointmentDetailView.swift
//  MuscleDiscovery
//
//  Created by Thuc on 16/9/2023.
//

import SwiftUI

struct AppointmentDetailView: View {
    // Bind presentation mode of DetailView to  the PokeListView and will be used by the custome back button to dismiss the view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var appointmentViewModel: AppointmentViewModel
    
    var appointment: Appointment
    
    static let dateFormat: DateFormatter = {
        let formartter = DateFormatter()
        
        formartter.dateFormat = "dd MMMM yyyy - EEEE"
        
        return formartter
    }()
    
    static let timeFormat: DateFormatter = {
        let formartter = DateFormatter()
        
        formartter.dateFormat = "hh:mm a"
        
        return formartter
    }()
    
    private let width = UIScreen.main.bounds.width*0.85
    
    @State var showingTabBar: Bool = false
    
    var backButton: some View {
        Button(action: {
            withAnimation() {
                self.showingTabBar = true
                self.presentationMode.wrappedValue.dismiss()
            }
        })  {
            Circle()
                .fill(ColorConstant.gray)
                .frame(height: 30)
                .overlay(alignment: .center, content: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                })
                .foregroundColor(.black)
                .shadow(color: .white.opacity(0.35), radius: 7)
        }
        .contentShape(Circle())
    }
    
    var body: some View {
        // MARK: Main ZStack for background
        ZStack {
            ColorConstant.black
                .edgesIgnoringSafeArea(.all)
            
            // MARK: Appointment info VStack
            VStack {
                TrainerRow(trainer: appointment.trainer!)
                    .frame(maxWidth: width, alignment: .center)
                
                Divider()
                    .background(ColorConstant.textGray)
                    .frame(width: width, alignment: .center)
                
                // MARK: Date Time info VStack
                VStack (spacing: 20) {
                    // MARK: Date VStack
                    VStack {
                        Text("Date")
                            .font(.body)
                            .frame(maxWidth: width, alignment: .leading)

                        
                        Text("\(appointment.date!, formatter: Self.dateFormat)")
                            .font(.headline)
                            .frame(maxWidth: width, alignment: .leading)
                    } // end Date VStack
                    
                    // MARK: Time VStack
                    VStack {
                        Text("Time")
                            .font(.body)
                            .frame(maxWidth: UIScreen.main.bounds.width*0.85, alignment: .leading)
                        
                        Text("\(appointment.date!, formatter: Self.timeFormat) - \(appointment.date! + 30*60, formatter: Self.timeFormat)")
                            .font(.headline)
                            .frame(maxWidth: width, alignment: .leading)
                    }

                } // end Date Time info VStack
                .frame(maxWidth: width, alignment: .leading)
                .foregroundColor(.white)
                .padding()
                
            } // end Appointment info VStack
            .frame(maxWidth: width, alignment: .leading)
            .background(
                Rectangle()
                    .fill(ColorConstant.gray)
                    .frame(width: width)
                    .cornerRadius(20)
            )
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top)
            
            HStack {
                Spacer()
                
                NavigationLink(destination: VideoCallView()) {
                    HStack {
                        Image(systemName: "phone.fill")
                        
                        Text("Join The Call")
                            
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .background(
                        Rectangle()
                        .fill(ColorConstant.luminousGreen)
                        .cornerRadius(25)
                        .frame(width: UIScreen.main.bounds.width*0.4)
                        .shadow(color: .white.opacity(0.4), radius: 4)
                    )
                }
                .padding(.leading)
                
                Spacer()
                
                Button(action: {
                    appointmentViewModel.removeAppointment(documentID: self.appointment.documentID!)
                    withAnimation() {
                        self.showingTabBar = true
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    HStack {
                        Image(systemName: "xmark")
                        
                        Text("Cancel")
                            
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .background(
                        Rectangle()
                            .fill(LinearConstant.linearOrange)
                        .cornerRadius(25)
                        .frame(width: UIScreen.main.bounds.width*0.4)
                        .shadow(color: .white.opacity(0.4), radius: 4)
                    )
                })
                .frame(width: UIScreen.main.bounds.width*0.4)
                
                Spacer()
                
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            
        } // end Main ZStack for background
        // MARK: Hide default Back Button
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .toolbar(showingTabBar ? .visible : .hidden, for: .tabBar)
    }
}

//struct AppointmentDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppointmentDetailView()
//            .en
//    }
//}
