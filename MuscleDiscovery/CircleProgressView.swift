//
//  CircleProgressView.swift
//  RMIT-Hackathon-Workout
//
//  Created by Minh Trương on 13/09/2023.
//

import SwiftUI

struct CircleProgressView: View {
    var progress: CGFloat = 55.6
    var isPercent: Bool = false
    var size: CGFloat = 0.0
    var targetCalo: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .stroke(
                        Color.pink.opacity(0.5),
                        lineWidth: size != 0 ? size : 15
                    )
                Circle()
                    .trim(from: 0, to: progress / 100)
                    .stroke(
                        Color.pink,
                        style: StrokeStyle(
                            lineWidth: size != 0 ? size : 15,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value:  progress / 100)
             }
            VStack(){
                Text("\(!isPercent ? targetCalo : progress, specifier: "%.\(!isPercent ? 0 : 2)f")\(isPercent ? "%" : "")")
                    .font(size != 0 ? .subheadline : .largeTitle)
                    .bold()
                if(!isPercent){
                    Text("cal left")
                        .bold()
                        .font(.subheadline)
                }
            }
        }
    }
}

//struct CircleProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        CircleProgressView()
//    }
//}

