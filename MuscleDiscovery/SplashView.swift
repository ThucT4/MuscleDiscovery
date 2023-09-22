import SwiftUI


/// Splash view layout
struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        // If splash view animated duration end, jump to Login view
        if isActive {
            MultipleOnboardingView()
        }
        else {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                
                VStack {
                    VStack(alignment: .center) {
                        Spacer()

                        Image("App Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400)
                            .padding(.bottom, -40)
                        
                        Text("DEV")
                            .font(.system(size: 80, weight: .heavy, design: .default))
                            .foregroundColor(Color("Neon"))
                        
                        Text("MUSCLES")
                            .font(.system(size: 60, weight: .heavy, design: .default))
                            .foregroundColor(Color("Neon"))
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right.circle")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                        
                        Text("Tap to go next")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(.top)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1
                        }
                    }
                } // VStack
                .onTapGesture {
                    isActive.toggle()
                }
            } // ZStack
        } // Splash view check
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
