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

struct CircularProgress: View {
    var percent: Double
    
    @State private var progress: Double = 0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color("Dark grey"),
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
        .modifier(Shadown3DModifier())
        .onAppear {
            self.progress = percent
        }
        .onDisappear {
            self.progress = 0.0
        }
    }
}
