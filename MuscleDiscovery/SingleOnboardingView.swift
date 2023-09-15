import SwiftUI


/// Instruction page
struct SingleOnboardingView: View {
    var page: Page
    
    var body: some View {
        ZStack {
            // Preview image
            Image("\(page.imgUrl)")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Spacer(minLength: 500)

                // Instruction
                VStack(alignment: .center, spacing: 3) {
                    Spacer(minLength: 30)
                    
                    Text(LocalizedStringKey(page.description[0]))
                        .fontWeight(.semibold)
                    
                    Text(LocalizedStringKey(page.description[1]))
                        .foregroundColor(Color("Neon"))
                        .fontWeight(.heavy)
                        .textCase(.uppercase)

                }
                .fixedSize(horizontal: true, vertical: true)
                .font(.system(size: 28))
                .foregroundColor(.white)
                .padding(.top, 200)
                
                Spacer()
            }
        }
    }
}

struct SingleOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        SingleOnboardingView(page: Page.pages[0])
        SingleOnboardingView(page: Page.pages[1])
        SingleOnboardingView(page: Page.pages[2])
    }
}
