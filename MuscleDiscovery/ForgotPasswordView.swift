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


/// Structure of forgot password page
struct ForgotPasswordView: View {
    @Binding var email: String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                
                VStack(alignment: .center) {
                    Spacer()

                    // -- TEXT --
                    VStack(alignment: .leading, spacing: 20) {
                        Text("FORGOT PASSWORD?")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                            .padding(.trailing, 20)

                        Text("Enter your informations below or \nlogin with a other account")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .lineSpacing(5)
                            .textCase(.uppercase)
                    }
                    .padding(.vertical, 30)
                    
                    InputView(text: $email, title: "Email", placeholder: "example@hotmail.com", isSecuredField: true)
                        .textInputAutocapitalization(.never)
                        .padding(.horizontal, 40)
                        .padding(.top, 12)
                        .padding(.bottom, 60)

                    Spacer()

                    Button {
                        print("Sending...")
                    } label: {
                        HStack(spacing: 15) {
                            Text("Send")
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                        }
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width - 100, height: 50)
                    }
                    .background(Color("Neon"))
                    .cornerRadius(48)
                    .padding(.top, 12)
                    Spacer()
                } // VStack
                .foregroundColor(.white)
            } // ZStack
            .edgesIgnoringSafeArea(.all)
        } // NavigationView
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton())
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(email: .constant(""))
    }
}
