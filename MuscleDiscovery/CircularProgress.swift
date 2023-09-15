//
//  CircularProgress.swift
//  MuscleDiscovery
//
//  Created by Thuc on 13/9/2023.
//

import SwiftUI

struct CircularProgress: View {
    var percent: Double
    
    @State private var progress: Double = 0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color(red: 0.24, green: 0.24, blue: 0.24),
                    lineWidth: 20
                )
                .frame(width: 150, height: 150)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearConstant.linearOrange,
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .frame(width: 150, height: 150)
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 2), value: progress)
        }
        .onAppear {
            self.progress = percent
        }
        .onDisappear {
            self.progress = 0.0
        }
    }
}

//struct CircularProgress_Previews: PreviewProvider {
//    static var previews: some View {
//        CircularProgress()
//    }
//}
