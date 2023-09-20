//
//  SettingsView.swift
//  MuscleDiscovery
//
//  Created by Vo Thanh Thong on 15/09/2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var premium: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // Back Button
    var backButton: some View {
        Button(action: {
            withAnimation() {
                self.presentationMode.wrappedValue.dismiss()
            }
        })  {
            Circle()
                .fill(ColorConstant.gray)
                .frame(height: 30)
                .overlay(alignment: .center, content: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                    
                })
                .foregroundColor(.black)
                .shadow(color: Color("BlackTransparent"), radius: 7)
        }
        .contentShape(Circle())
        .padding(.trailing, 20)
    }
    
    var body: some View {
        if viewModel.isLoggedIn {
            if let user = viewModel.currentUser {
                NavigationView {
                    ZStack {
                        ColorConstant.black
                            .ignoresSafeArea()
                        
                        VStack (alignment: .leading) {
                            Spacer()
                            
                            // Profile Information
                            HStack {
                                
                                // Profile Picture
                                ZStack {
                                    Circle()
                                        .trim(from: 0.0, to: 0.75) // Trim 75% of the circle
                                        .stroke(
                                            LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing),
                                            lineWidth: 3
                                        )
                                        .frame(width: 100, height: 100)
                                        .rotationEffect(.degrees(-90)) // Rotate to start at the top
                                    
                                    Text(user.initials)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .frame(width: 80, height: 80)
                                        .background(.gray)
                                        .clipShape(Circle())
                                }
                                .padding(.trailing, 65)
                                
                                Divider()
                                    .background(.gray)
                                    .frame(height: 80)
                                
                                // Profile Information
                                VStack (alignment: .leading) {
                                    Text("Joined")
                                        .foregroundColor(.gray)
                                    Text("2 month ago")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 120, height: 100)
                                
                            }
                            
                            // User Name
                            VStack {
                                Text(user.fullname.split(separator: " ").first ?? "John")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                Text(user.fullname.split(separator: " ").last ?? "Doe")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical)
                            
                            // Navigation Button
                            VStack {
                                Divider()
                                    .background(.gray)
                                    .padding(.bottom, 15)
                                
                                // Navigate to Edit Profile Page
                                NavigationLink(destination: EditProfileView()) {
                                    VStack {
                                        HStack {
                                            Text("Edit Profile")
                                                .font(.title3)
                                                .bold()
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "arrow.right")
                                                .foregroundColor(.white)
                                        }
                                        .padding(.bottom, 15)
                                        
                                        Divider()
                                            .background(.gray)
                                    }
                                    .padding(.bottom, 15)
                                }
                                
                                // Navigate to Privacy Policy Page
                                NavigationLink (destination: PrivacyPolicyView()) {
                                    VStack {
                                        HStack {
                                            Text("Privacy Policy")
                                                .font(.title3)
                                                .bold()
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "arrow.right")
                                                .foregroundColor(.white)
                                        }
                                        .padding(.bottom, 15)
                                        
                                        Divider()
                                            .background(.gray)
                                    }
                                    .padding(.bottom, 15)
                                }
                                
                                // Navigate to Settings App Page
                                NavigationLink (destination: SettingsAppView()) {
                                    VStack {
                                        HStack {
                                            Text("Settings")
                                                .font(.title3)
                                                .bold()
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "arrow.right")
                                                .foregroundColor(.white)
                                        }
                                        .padding(.bottom, 15)
                                    }
                                }
                                    
                                    
                                    Divider()
                                        .background(.gray)
                                
                            }
        //                    .padding(.bottom, 30)
                            
                            // Upgrade to Premium
                            VStack (alignment: .leading) {
                                // Pro Tag
                                ZStack {
                                    Rectangle()
                                        .fill(Color.red) // Fill color of the rectangle
                                        .frame(width: 37, height: 18) // Size of the rectangle
                                        .cornerRadius(5)
                                    Text("PRO")
                                        .font(.custom("tag", fixedSize: 14))
                                        .bold()
                                        .foregroundColor(.white)
                                }
                                .padding(.leading, 10)
                                
                                HStack {
                                    Text("Upgrade to Premium")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 10)
                                
                                Text("This subscription is auto-renewable")
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)
                                    .padding(.top, 1)
                            }
                            .frame(width: 330, height: 100)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(12)
        //                    .padding(.bottom, 40)
                            
                            
                            // Log out option
                            Divider()
                                .background(.gray)
                                .padding(.bottom, 15)
                            
                            // Log Out Button
                            VStack {
                                HStack {
                                    Button {
                                        Task {
                                            viewModel.signOut()
                                        }
                                        print("DEBUG: Sign out success!")
                                    } label: {
                                        Text("Sign Out")
                                            .font(.title3)
                                            .bold()
                                            .foregroundColor(.red)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.bottom, 15)
                                
                                Divider()
                                    .background(.gray)
                            }
                            .padding(.bottom, 50)
                        }
                        .frame(width: 330)
                    }
                    // MARK: Hide default Back Button
                    .navigationBarBackButtonHidden(true)
        //                .toolbar {
        //                    ToolbarItem(placement: .principal) {
        //                        HStack (spacing: 20) {
        //                            backButton
        //                        }
        //                        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
        //                    }
        //                }
                }
            }

        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthViewModel()) // Provide an instance of AuthViewModel
    }
}
