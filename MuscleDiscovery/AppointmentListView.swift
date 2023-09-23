/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2023B
    Assessment: Assignment 3
    Author: Lai Nghiep Tri, Thieu Tran Tri Thuc, Truong Bach Minh, Vo Thanh Thong
    ID: s3799602, s3870730, s3891909, s3878071
    Created  date: 12/9/2023
    Last modified: 25/9/2023
    Acknowledgement:
        - The UI designs are inspired from:
            “Gym fitness app ui kit: Figma community,” Figma, https://www.figma.com/community/file/1096744662320428503 (accessed Sep. 12, 2023).
 */

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
                            .foregroundColor(Color("Text gray"))
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
