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
    @Binding var targetCalo: CGFloat
    
    // MARK: This component constructed to show the circle progress (in percent or progress (float))
    
    var body: some View {
        
        // MARK: Main ZStack for background
        ZStack {
            // MARK: Another ZStack to set Circle as background
            
            ZStack {
                
                Circle()
                    .stroke(
                        LinearConstant.linearOrange.opacity(0.5),
                        lineWidth: size != 0 ? size : 15
                    )
                
                Circle()
                    .trim(from: 0, to: progress / 100)
                    .stroke(
                        LinearConstant.linearOrange,
                        style: StrokeStyle(
                            lineWidth: size != 0 ? size : 15,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value:  progress / 100)
             }
            
            // MARK: VStack is displayed in middle of circle to show info
            VStack(){
                
                if(targetCalo < 0){
                    Text("\(!isPercent ? -targetCalo : progress, specifier: "%.\(!isPercent ? 0 : 2)f")\(isPercent ? "%" : "")")
                        .font(size != 0 ? .subheadline : .largeTitle)
                        .bold()
                    if(!isPercent){
                        Text("cal over")
                            .bold()
                            .font(.subheadline)
                    }
                }
                
                else{
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
        }//end of ZStack
    }
}


