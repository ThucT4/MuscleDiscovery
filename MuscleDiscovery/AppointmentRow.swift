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
        
        return formartter
    }()
    
    static let dateTimeFormatter2: DateFormatter = {
        let formartter = DateFormatter()
        
        formartter.dateFormat = "HH:mm"
        
        return formartter
    }()
    
    var body: some View {
        // MARK: Appointment
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
                    
                    Text("\(appointment.date!, formatter: Self.dateTimeFormatter2) - \(appointment.date! + 30*60, formatter: Self.dateTimeFormatter2)")
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
}