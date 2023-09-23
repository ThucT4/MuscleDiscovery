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

struct AppointmentDetailView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
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
        // MARK: Main ZStack for background
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            // MARK: Appointment info VStack
            VStack {
                TrainerRow(trainer: appointment.trainer!)
                    .frame(maxWidth: width, alignment: .center)
                
                Divider()
                    .background(Color("Text gray"))
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
                .padding()
                
            } // end Appointment info VStack
            .frame(maxWidth: width, alignment: .leading)
            .background(
                Rectangle()
                    .fill(Color("Dark grey"))
                    .frame(width: width)
                    .cornerRadius(20)
            )
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top)
            
            HStack {
                Spacer()
                
                NavigationLink(destination: VideoCallView(appointment: appointment)) {
                    HStack {
                        Image(systemName: "phone.fill")
                        
                        Text("Join The Call")
                            
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .background(
                        Rectangle()
                        .fill(Color("Neon"))
                        .cornerRadius(25)
                        .frame(maxWidth: UIScreen.main.bounds.width*0.4)
                        .shadow(color: .white.opacity(0.4), radius: 4)
                        .modifier(Shadown3DModifier())
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
                        .frame(maxWidth: UIScreen.main.bounds.width*0.4)
                        .modifier(Shadown3DModifier())
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
