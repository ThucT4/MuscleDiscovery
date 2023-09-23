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
import SDWebImageSwiftUI

struct AnimatedSplashView: View {
    @Binding var showingMainView: Bool
    
    @State var animating: Bool = false
    
    var body: some View {
        ZStack {
            Color(red: 0.11, green: 0.11, blue: 0.12)
                .ignoresSafeArea(.all)
            
            VStack {
                AnimatedImage(url: Bundle.main.url(forResource: "fitness", withExtension: "gif"))
                    .customLoopCount(1)
                    .resizable()
                    .playbackRate(1.0)
                    .scaledToFit()
                
                VStack (spacing: 0) {
                    Text("Muscles")
                        .font(.custom("Integral CF", size: 60))
                        .fontWeight(.heavy)
                    
                    Text("Discovery")
                        .font(.custom("Integral CF", size: 40))
                }
                .foregroundColor(Color("Neon"))
                .offset(y: animating ? -35 : 35)
                .opacity(animating ? 1 : 0)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                withAnimation {
                    showingMainView = true
                }
            })

            withAnimation(.easeIn(duration: 0.3).delay(1.3)) {
                self.animating = true
            }
        }
    }
}
