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

/// Structure of login page
struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var fullname: String = ""
    @State var confirmedPassword : String = ""
    
    @State var message: String = ""

    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("login-wallpaper")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    // -- Sign up link --
                    NavigationLink(destination: RegistrationView()) {
                        HStack {
                            Text("Sign up")
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 32)
                    .padding(.top, 58)
                    
                    Spacer()
                    
                    Text("WELCOME")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.vertical, 140)
                        .padding(.trailing, 120)
                    
                    
                    // -- INPUT FORM --
                    VStack(spacing: 24) {
                        InputView(text: $email, title: "Email", placeholder: "example@hotmail.com", isSecuredField: false)
                            .textInputAutocapitalization(.never)
                        
                        InputView(text: $password, title: "Password", placeholder: "Enter your password...", isSecuredField: true)
                            .textInputAutocapitalization(.never)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 12)
                    .padding(.vertical, 30)
                    
                    Spacer()
                    
                    Text(message)
                        .font(.body)
                        .foregroundColor(.red)
                    
                    // -- LOGIN --
                    HStack {
                        Spacer()
                        
                        // Face ID option
                        Button(action: {
                            let email = UserDefaults.standard.string(forKey: "email")
                            let password = UserDefaults.standard.string(forKey: "password")
                            
                            // DEBUG
                            print(email!, password!)
                            
                            Task {
                                let result = await viewModel.authenticate()
                                
                                if (result == 1) {
                                    try await viewModel.signIn(email: email!, password: password!)
                                }
                                else if (result == -1) {
                                    self.message = "Your device does not suppot Face ID!"
                                }
                            }
                        }, label: {
                            Image(systemName: "faceid")
                                .foregroundColor(.black)
                                .padding()
                                .background(
                                    Circle()
                                        .fill(Color("Neon"))
                                )
                        })
                        .disabled(UserDefaults.standard.string(forKey: "email") == nil)
                        .opacity(UserDefaults.standard.string(forKey: "email") == nil ? 0.3 : 1.0)
                        
                        Spacer()
                        
                        // Manually login with email and password
                        Button {
                            Task {
                                try await viewModel.signIn(email: email, password: password)
                            }
                        } label: {
                            HStack(spacing: 15) {
                                Text("Login")
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
                        .padding(.top, 12)
                        .padding(.trailing, 30)
                    }
                    
                    Spacer()
                } // VStack
            } // ZStack
        } // NavigationView
        .navigationBarHidden(true)
        
    }
}

extension LoginView: AuthenticationFormProtocol {
    // Allow to sign in if
    // 1. Email is not empty
    // 2. Email contains @ char
    // 3. Password is not empty
    // 4. Password have at least 6 characters
    var formIsActive: Bool {
        return !email.isEmpty && email.contains("@")
        && !password.isEmpty && password.count >= 6
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
