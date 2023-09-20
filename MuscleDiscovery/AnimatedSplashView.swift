//
//  AnimatedSplashView.swift
//  MuscleDiscovery
//
//  Created by Thuc on 18/9/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct AnimatedSplashView: View {
    @Binding var showingMainView: Bool
    
    @State var animating: Bool = false
    
    var body: some View {
        ZStack {
            ColorConstant.black
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
                .foregroundColor(ColorConstant.luminousGreen)
                .offset(y: animating ? -35 : 35)
                .opacity(animating ? 1 : 0)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7, execute: {
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
