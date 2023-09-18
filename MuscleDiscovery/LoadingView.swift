//
//  LoadingView.swift
//  MuscleDiscovery
//
//  Created by Trí Lai on 18/09/2023.
//

import SwiftUI
import Combine

struct LoadingView: View {
    @State var isAnimation: Bool = false
    
    let timing: Double
    let maxCounter = 3
    let frame: CGSize
    let primaryColor: Color
    
    init(color: Color = Color("Neon"), size: CGFloat = 90, speed: Double = 0.5) {
        timing = speed * 2
        frame = CGSize(width: size, height: size)
        primaryColor = color
    }
    
    
    var body: some View {
        
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(primaryColor)
                        .frame(height: frame.height / 3)
                        .offset(
                            x: 0,
                            y: isAnimation ? -frame.height / 3 : 0
                        )
                    
                    Circle()
                        .fill(primaryColor)
                        .frame(height: frame.height / 3)
                        .offset(
                            x: isAnimation ? -frame.height / 3 : 0,
                            y: isAnimation ? frame.height / 3 : 0
                        )
                    
                    Circle()
                        .fill(primaryColor)
                        .frame(height: frame.height / 3)
                        .offset(
                            x: isAnimation ? frame.height / 3 : 0,
                            y: isAnimation ? frame.height / 3 : 0
                        )
                }
                .animation(Animation.easeInOut(duration: timing).repeatForever(autoreverses: true))
                .frame(width: frame.width, height: frame.height, alignment: .center)
                .rotationEffect(Angle(degrees: isAnimation ? 360 : 0))
                .animation(Animation.easeInOut(duration: timing).repeatForever(autoreverses: false))
                .onAppear {
                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + 2.0,
                        execute: {
                        isAnimation.toggle()
                    })
                } // Inner ZStack: Loading dot frame
                
                Text("Please wait...")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Neon"))
                    .padding(.top, 60)
                
                Spacer()
                
                HStack(spacing: 5) {
                    Text("\(Image(systemName: "lightbulb.fill")) Don't forget to refuel fruit if you expect your body to recover, get stronger, and be ready for the next challenge.")
                }
                .foregroundColor(.white)
                .font(.footnote)
                .padding()
            } // VStack

        } // Outter ZStack
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
