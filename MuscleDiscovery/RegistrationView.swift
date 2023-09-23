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

/// Structure of sign up page
struct RegistrationView: View {
    @State var email: String = ""
    @State var fullname: String = ""
    @State var password: String = ""
    @State var confirmedPassword : String = ""
            
    @EnvironmentObject var viewModel: AuthViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Image("signup-wallpaper")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer(minLength: 180)
                
                // -- WELCOME TEXT --
                VStack(alignment: .leading, spacing: 20) {
                    Text("HELLO ROOKIES,")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.trailing, 20)
                    
                    Text("Enter your informations below or \nlogin with a other account")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                        .lineSpacing(5)
                        .textCase(.uppercase)
                }
                .padding(.leading)
                
                Spacer(minLength: 60)
                
                // -- INPUT FORM --
                VStack(spacing: 24) {
                    InputView(text: $email, title: "Email", placeholder: "example@hotmail.com", isSecuredField: false)
                        .textInputAutocapitalization(.never)
                    
                    InputView(text: $fullname, title: "Fullname", placeholder: "Enter your name", isSecuredField: false)
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your password...", isSecuredField: true)
                    
                    ZStack(alignment: .trailing) {
                        InputView(text: $confirmedPassword, title: "Password again", placeholder: "Enter password again", isSecuredField: true)
                        
                        // Matching password icon
                        if (!password.isEmpty && !confirmedPassword.isEmpty) {
                            if (password == confirmedPassword) {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "x.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                            }
                        }
                    } // ZStack: Signup button
                } // VStack - Input
                .padding(.horizontal, 40)
                .padding(.bottom)
                                    
                // -- SIGNUP --
                HStack {
                    // Signup status message
                    if viewModel.isSignupSuccess {
                        Text("Signup Success ✅")
                        .foregroundColor(.green)
                        .padding(.leading, 30)
                    } else {
                        Text("Signup not done! ❌")
                        .foregroundColor(.red)
                        .padding(.leading, 30)
                    }
                    
                    Spacer()
                    
                    // Registrate for new account action
                    Button {
                        Task {
                            try await viewModel.createUser(email: email, password: password, fullname: fullname)
                        }
                        
                     } label: {
                        HStack(spacing: 15) {
                            Text("Sign up")
                                .fontWeight(.semibold)
                            
                            Image(systemName: "arrowtriangle.forward.fill")
                        }
                        .foregroundColor(.black)
                        .frame(width: 125, height: 50)
                    }
                    .disabled(!formIsActive)
                    .background(Color("Neon"))
                    .opacity(formIsActive ? 1.0 : 0.3)
                    .cornerRadius(48)
                    .padding(.trailing, 30)
                } // HStack - SIGNUP
                
                Spacer()
            } // VStack
        } // ZStack
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton())
    }
    
    /// Navigate back to parent view
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

extension RegistrationView: AuthenticationFormProtocol {
    // Allow to sign up if
    // 1. Email is not empty
    // 2. Email contains @ char
    // 3. Password is not empty
    // 4. Password have at least 6 characters
    // 5. Fullname is not empty
    // 6. Confirm correct password
    var formIsActive: Bool {
        return !email.isEmpty && email.contains("@")
        && !password.isEmpty && password.count >= 6
        && !fullname.isEmpty && password == confirmedPassword
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .preferredColorScheme(.dark)
    }
}
