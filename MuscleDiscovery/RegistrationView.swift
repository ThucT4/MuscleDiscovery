import SwiftUI

struct RegistrationView: View {
    @State var email: String = ""
    @State var fullname: String = ""
    @State var password: String = ""
    @State var confirmedPassword : String = ""
    
    @State private var isLoginActive = true
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
//        NavigationStack {
//        } // NavigationView
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: backButton())
        
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
                    InputView(text: $email, title: "Email", placeholder: "example@hotmail.com")
                        .textInputAutocapitalization(.never)
                    
                    InputView(text: $fullname, title: "Fullname", placeholder: "Enter your name")
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your password...")
                    
                    ZStack(alignment: .trailing) {
                        InputView(text: $confirmedPassword, title: "Password again", placeholder: "Enter password again")
                        
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
                    }
                } // VStack - Input
                .padding(.horizontal, 40)
                .padding(.bottom)
                                    
                // -- SIGNUP --
                HStack {
                    Spacer()
                    
                    Button {
                        Task {
                            try await viewModel.createUser(email: email, password: password, fullname: fullname)
                        }
                        
                        dismiss()
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
