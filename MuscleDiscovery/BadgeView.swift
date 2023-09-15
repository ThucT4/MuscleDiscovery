//
//  BadgeView.swift
//  RMIT-Hackathon-Workout
//
//  Created by Minh Trương on 13/09/2023.
//

import SwiftUI

struct BadgeView: View {
    var tags: [String]
    var body: some View {
        HStack(){
            ForEach(tags, id: \.self){tag in
                HStack(spacing: 0){
//                    Text(Image(systemName: ))
//                        .frame(height: 12)
//                        .bold()
//                        .foregroundColor(Color(.white))
//                        .padding(.leading, 3)
                    Text(tag)
                        .font(.system(size: 12))
                        .bold()
                        .foregroundColor(ColorConstant.black)
                        .textCase(.uppercase)
                        .padding(.all, 4)
                }
                .background(ColorConstant.luminousGreen)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            }
        }
    }
}

//struct BadgeView_Previews: PreviewProvider {
//    static var previews: some View {
//        BadgeView(tags: Foods[0].tags)
//    }
//}

