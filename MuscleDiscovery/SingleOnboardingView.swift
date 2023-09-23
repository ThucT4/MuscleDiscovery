/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Lai Nghiep Tri, Thieu Tran Tri Thuc, Truong Bach Minh, Vo Thanh Thong
  ID: s3799602, s3870730, s3891909, s3878071
  Created  date: 23/09/2023
  Last modified: 23/09/2023
  Acknowledgement: iOS Development course (lecture and tutorial material slides), Apple Documentation, Code With Chris, Hacking with Swift, Medium.
*/

import SwiftUI

/// Structure of scingle onboarding page
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

                // Introducing text
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
            } // VStack
        } // ZStack
    }
}

struct SingleOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        SingleOnboardingView(page: Page.pages[0])
        SingleOnboardingView(page: Page.pages[1])
        SingleOnboardingView(page: Page.pages[2])
    }
}
