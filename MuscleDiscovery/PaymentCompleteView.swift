//
//  PaymentCompleteView.swift
//  MuscleDiscovery
//
//  Created by Thuc on 13/9/2023.
//

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
        
        return formartter
    }()
    
    static let timeFormat: DateFormatter = {
        let formartter = DateFormatter()
        
        formartter.dateFormat = "hh:mm a"
        
        return formartter
    }()
    
    private let width = UIScreen.main.bounds.width*0.85
    
    var body: some View {
        // MARK: Main ZStack for background
        ZStack {
            ColorConstant.black
                .edgesIgnoringSafeArea(.all)
            
            // MARK: Main VStack
            VStack (spacing: 20) {
                // MARK: Payment completet HStack
                HStack {
                    Image(systemName: "checkmark.square.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(ColorConstant.luminousGreen)
                    
                    Text("Payment Completed!")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                } // endPayment completet HStack
                .frame(maxWidth: width, alignment: .leading)
                
                Text("You've book a new appointment with your trainer.")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(ColorConstant.textGray)
                    .frame(maxWidth: width, alignment: .leading)
                
                // MARK: Appointment info VStack
                VStack {
                    TrainerRow(trainer: trainer)
                        .frame(maxWidth: width, alignment: .center)
                    
                    Divider()
                        .background(ColorConstant.textGray)
                        .frame(width: width, alignment: .center)
                    
                    // MARK: Date Time info VStack
                    VStack (spacing: 20) {
                        // MARK: Date VStack
                        VStack {
                            Text("Date")
                                .font(.system(size: 15, weight: .medium))
                                .frame(maxWidth: width, alignment: .leading)

                            
                            Text("\(date, formatter: Self.dateFormat)")
                                .font(.system(size: 15, weight: .semibold))
                                .frame(maxWidth: width, alignment: .leading)
                        } // end Date VStack
                        
                        // MARK: Time VStack
                        VStack {
                            Text("Time")
                                .font(.system(size: 15, weight: .medium))
                                .frame(maxWidth: UIScreen.main.bounds.width*0.85, alignment: .leading)
                            
                            Text("\(date, formatter: Self.timeFormat)")
                                .font(.system(size: 15, weight: .semibold))
                                .frame(maxWidth: width, alignment: .leading)
                        }

                    } // end Date Time info VStack
                    .frame(maxWidth: width, alignment: .leading)
                    .foregroundColor(.white)
                    .padding()
                    
                } // end Appointment info VStack
                .frame(maxWidth: width, alignment: .leading)
                .padding()
                .background(
                    Rectangle()
                        .fill(ColorConstant.gray)
                        .frame(width: width)
                        .cornerRadius(20)
                )
                
            } // end Main VStack
            
            Text("Done")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
                .padding()
                .background(
                    Button(action: {
                        print("ENtered")
                        self.showing = false
                    }, label: {
                        Rectangle()
                        .fill(ColorConstant.luminousGreen)
                        .cornerRadius(25)
                        .frame(width: UIScreen.main.bounds.width*0.7)
                        .shadow(color: .white.opacity(0.4), radius: 4)
                    })
                    
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
            
        } // end Main ZStack for background
        .navigationBarBackButtonHidden(true)
    }
}

//struct PaymentCompleteView_Previews: PreviewProvider {
//    static var previews: some View {
//        PaymentCompleteView(date: Date.now)
//    }
//}
