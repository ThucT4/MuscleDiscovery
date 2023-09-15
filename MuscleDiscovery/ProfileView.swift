import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(.gray)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .tint(.gray)
                        }
                    }
                }
                
                Section {
                    HStack {
                        SettingRowView(imageName: "gear", title: "Version", tintColor: .gray )
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                } header: {
                    Text("General")
                }
                
                Section {
                    Button {
                        Task {
                            viewModel.signOut()
                        }
                    } label: {
                        SettingRowView(imageName: "door.left.hand.open", title: "Logout", tintColor: .red)
                    }
                    
                    Button {
                        print("Deleting account...")
                    } label: {
                        SettingRowView(imageName: "person.crop.circle.fill.badge.xmark", title: "Delete account", tintColor: .red)
                    }
                } header: {
                    Text("Account")
                }
            }
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
