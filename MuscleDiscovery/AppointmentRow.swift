//
//  AppointmentRow.swift
//  MuscleDiscovery
//
//  Created by Thuc on 16/9/2023.
//

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
