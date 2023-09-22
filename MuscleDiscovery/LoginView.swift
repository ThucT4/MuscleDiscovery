import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var fullname: String = ""
    @State var confirmedPassword : String = ""

    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Image("login-wallpaper")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    // -- HEADER --
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
                    
//                    HStack {
//                        Spacer()
//                        NavigationLink(destination: ForgotPasswordView(email: $email)) {
//                            Text("Forget Password")
//                                .font(.system(size: 13))
//                        }
//                    }
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("Neon"))
//                    .padding(.horizontal, 42)
                    
                    Spacer()
                    
                    // -- LOGIN --
                    HStack {
//                        HStack(spacing: 20) {
//                            // Apple icon
//                            Image(systemName: "apple.logo")
//                                .foregroundColor(.white)
//                                .padding()
//                                .background(Color("Dark grey"))
//                                .clipShape(Circle())
//
//                            // Google icon
//                            Image("google.logo")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 20)
//                                .padding()
//                                .background(Color("Dark grey"))
//                                .clipShape(Circle())
//                        }
//                        .padding(.top, 12)
//                        .padding(.leading, 35)
                        
                        Spacer()
                        
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
                }
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
