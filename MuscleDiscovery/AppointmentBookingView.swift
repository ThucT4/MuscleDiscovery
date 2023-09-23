//
//  AppointmentBookingView.swift
//  MuscleDiscovery
//
//  Created by Thuc on 13/9/2023.
//

import SwiftUI

struct AppointmentBookingView: View {
    // Bind presentation mode of DetailView to  the PokeListView and will be used by the custome back button to dismiss the view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
    @EnvironmentObject var appointmentViewModel: AppointmentViewModel
    
    var trainer: Trainer
    
    @State private var selectedDate = Date.now.ceil(precision: 30)
    
    @State var isValid: Bool = true
    
    @Binding var showing: Bool
    
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
        // MARK: Main ZStack for background
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            //MARK: Main VStack
            VStack (spacing: 20) {
                TrainerRow(trainer: trainer)
                    .frame(maxWidth: UIScreen.main.bounds.width*0.9)
                
                DatePicker("", selection: self.$selectedDate, in: Date.now.round(precision: 15)...)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(maxWidth: UIScreen.main.bounds.width*0.9)
                    .background(Color("Dark grey"), in: RoundedRectangle(cornerRadius: 15))
                    .accentColor(Color("Neon"))
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                    .onAppear{
                        // Set time interval for time picker
                        UIDatePicker.appearance().minuteInterval = 30
                    }
                
                Text("\(isValid ? "" : "You had an appoint in this time!")")
                    .font(.body)
                    .foregroundColor(.red)
                
                Spacer()
                
            } // end Main VStack
            .padding(.top)
            
            Text("Next")
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .background(
                    // MARK: Button to Navigate to booking view
                    NavigationLink(destination: PaymentCompleteView(date: selectedDate, trainer: trainer, showing: self.$showing)) {
                        Rectangle()
                            .fill(ColorConstant.luminousGreen)
                            .cornerRadius(25)
                            .frame(width: UIScreen.main.bounds.width*0.7)
                            .shadow(color: .white.opacity(0.4), radius: 4)
                            .opacity(isValid ? 1 : 0.5)
                            .modifier(Shadown3DModifier())

                    }
                    .disabled(!isValid)
                    .simultaneousGesture(TapGesture().onEnded({
                        if (isValid) {
                            self.appointmentViewModel.bookAppointment(trainerID: trainer.documentID!, date: self.selectedDate)
                        }
                    }))
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
            
        } // end Main ZStack for background
        .onChange(of: selectedDate) {newValue in
            isValid = appointmentViewModel.userAppointments.filter { $0.date! == selectedDate}.isEmpty
        }
        // MARK: Hide default Back Button
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack (spacing: 50) {
                    backButton

                    Text("APPOINTMENT")
                        .font(.title2)
                        .fontWeight(.heavy)
                }
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
            }

        }
    }
    
}
