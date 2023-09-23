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

struct PaymentCompleteView: View {
    // Bind presentation mode of DetailView to  the PokeListView and will be used by the custome back button to dismiss the view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var date: Date
    
    var trainer: Trainer
    
    @Binding var showing: Bool
    
    static let dateFormat: DateFormatter = {
        let formartter = DateFormatter()
        
        formartter.dateFormat = "dd MMMM yyyy - EEEE"
        
        formartter.locale = Locale(identifier: "en_US_POSIX")
        
        return formartter
    }()
    
    static let timeFormat: DateFormatter = {
        let formartter = DateFormatter()
        
        formartter.dateFormat = "hh:mm a"
        
        formartter.locale = Locale(identifier: "en_US_POSIX")
        
        return formartter
    }()
    
    private let width = UIScreen.main.bounds.width*0.85
    
    var body: some View {
        // MARK: Main ZStack for background
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            // MARK: Main VStack
            VStack (spacing: 20) {
                // MARK: Payment completet HStack
                HStack {
                    Image(systemName: "checkmark.square.fill")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Neon"))
                    
                    Text("Payment Completed!")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                } // endPayment completet HStack
                .frame(maxWidth: width, alignment: .leading)
                
                Text("You've book a new appointment with your trainer.")
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .foregroundColor(Color("Text gray"))
                    .frame(maxWidth: width, alignment: .leading)
                
                // MARK: Appointment info VStack
                VStack {
                    TrainerRow(trainer: trainer)
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

                            
                            Text("\(date, formatter: Self.dateFormat)")
                                .font(.headline)
                                .frame(maxWidth: width, alignment: .leading)
                        } // end Date VStack
                        
                        // MARK: Time VStack
                        VStack {
                            Text("Time")
                                .font(.body)
                                .frame(maxWidth: UIScreen.main.bounds.width*0.85, alignment: .leading)
                            
                            Text("\(date, formatter: Self.timeFormat) - \(date + 30*60, formatter: Self.timeFormat)")
                                .font(.headline)
                                .frame(maxWidth: width, alignment: .leading)
                        }

                    } // end Date Time info VStack
                    .frame(maxWidth: width, alignment: .leading)
                    .padding()
                    
                } // end Appointment info VStack
                .frame(maxWidth: width, alignment: .leading)
                .padding()
                .background(
                    Rectangle()
                        .fill(Color("Dark grey"))
                        .frame(width: width)
                        .cornerRadius(20)
                )
                
            } // end Main VStack
            
            Text("Done")
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .background(
                    Button(action: {
                        self.showing = false
                    }, label: {
                        Rectangle()
                        .fill(Color("Neon"))
                        .cornerRadius(25)
                        .frame(width: UIScreen.main.bounds.width*0.7)
                        .shadow(color: .white.opacity(0.4), radius: 4)
                    })
                    
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
                .modifier(Shadown3DModifier())
            
        } // end Main ZStack for background
        .navigationBarBackButtonHidden(true)
    }
}
