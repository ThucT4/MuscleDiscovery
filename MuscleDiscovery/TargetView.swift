//
//  TargetView.swift
//  RMIT-Hackathon-Workout
//
//  Created by Minh Trương on 13/09/2023.
//

import SwiftUI

struct TargetView: View {
    var name: String
    var current: CGFloat
    var max: CGFloat
    var body: some View {
        VStack(){
            Text(name)
                        .bold()
            ProgressView(value: Float(current),
                         total: Float(max))
            .tint(ColorConstant.luminousGreen)
            .scaleEffect(x: 1, y: 2, anchor: .center)
            .padding(.horizontal, 20)
            Text("\(current, specifier: "%.0f")")
                .bold()
                .foregroundColor(current > max ? ColorConstant.textWarning : .white)
            + Text("/\(max, specifier: "%.0f")")
                .bold()
        }
    }
}

struct TargetView_Previews: PreviewProvider {
    static var previews: some View {
        TargetView(name: "Protein", current: 23.0, max: 230.0)
            .preferredColorScheme(.dark)
    }
}

