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

struct AppointmentRow: View {
    var appointment: Appointment
    
    static let dateTimeFormatter1: DateFormatter = {
        let formartter = DateFormatter()
        
        formartter.dateFormat = "EEE d MMM yyyy"
        
        formartter.locale = Locale(identifier: "en_US_POSIX")
        
        return formartter
    }()
    
    static let dateTimeFormatter2: DateFormatter = {
        let formartter = DateFormatter()
        
        formartter.dateFormat = "HH:mm"
        
        formartter.locale = Locale(identifier: "en_US_POSIX")
        
        return formartter
    }()
    
    var body: some View {
        // MARK: Appointment
        HStack {
            Text("\(appointment.date!, formatter: Self.dateTimeFormatter1)")
                .font(.caption)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.width*0.15)
            
            // MARK: Main HStack
            HStack {
                // Circle to take space while waiting for image loading
                Circle()
                    .fill(Color("Dark grey"))
                    .frame(width: 70)
                    .overlay(alignment: .center, content: {
                        AsyncImage(url: URL(string: appointment.trainer!.imageURL ?? "")!) {image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 70)
                        } placeholder: {
                            ProgressView()
                                .tint(Color("Neon"))
                        }
                    })
                    .padding()
                
                VStack {
                    HStack (spacing: 5) {
                        Text(appointment.trainer!.name!)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("\(appointment.trainer!.rating!.clean)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(4)
                            .background(
                                Rectangle()
                                    .fill(Color("Neon"))
                                    .cornerRadius(5)
                            )
                        
                        Spacer()
                        
                    }
                    
                    Text("\(appointment.date!, formatter: Self.dateTimeFormatter2) - \(appointment.date! + 30*60, formatter: Self.dateTimeFormatter2)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                
            } // end Main HStack
            .background(Color("Dark grey"))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
        } // end Appointment HStack
        .modifier(Shadown3DModifier())
    }
}
