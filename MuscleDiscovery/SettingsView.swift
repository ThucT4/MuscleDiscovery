//
//  SettingsView.swift
//  MuscleDiscovery
//
//  Created by Vo Thanh Thong on 15/09/2023.
//

import SwiftUI

enum Theme {
    static let darkMode = false
}

struct SettingsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    // Save systemTheme to AppStorage to save user option for the next using and access from other view
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
    @State private var premium: Bool = false
    
    private var imageURL: URL {
        return URL(string: viewModel.currentUser?.imageUrl ?? "https://firebasestorage.googleapis.com/v0/b/muscledicovery.appspot.com/o/avatars%2Favatar-default-icon.png?alt=media&token=7571f663-6784-4e27-a9c1-8eec9e3c6742")!
    }
    
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
                        // Background Color
                        Color("Background")
                            .ignoresSafeArea(.all)
                        
                        VStack (alignment: .leading) {
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
                                        .frame(width: 120, height: 120)
                                        .rotationEffect(.degrees(-90)) // Rotate to start at the top
                                    
                                    //                                    URL(string: "https://firebasestorage.googleapis.com/v0/b/muscledicovery.appspot.com/o/avatars%2Favatar-default-icon.png?alt=media&token=7571f663-6784-4e27-a9c1-8eec9e3c6742")
                                    
                                    
                                    AsyncImage(url: imageURL) {image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 120)
                                    } placeholder: {
                                        ProgressView()
                                            .tint(Color("Neon"))
                                    }
                                }
                                .padding(.trailing)
                                
                                Divider()
                                    .background(.gray)
                                    .frame(height: 80)
                                
                                // Profile Information
                                VStack (alignment: .leading) {
                                    Text(user.fullname.split(separator: " ").first ?? "John")
                                        .font(.title)
                                        .foregroundColor(isDarkMode ? Color.white : Color.black)
                                    Text(user.fullname.split(separator: " ").last ?? "Doe")
                                        .font(.title)
                                        .foregroundColor(isDarkMode ? Color.white : Color.black)
                                }
                                .frame(width: 120, height: 100)
                                
                            }
                            .padding(.bottom, 50)
                            
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
                                                .foregroundColor(isDarkMode ? Color.white : Color.black)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "arrow.right")
                                                .foregroundColor(isDarkMode ? Color.white : Color.black)
                                        }
                                        .padding(.bottom, 15)
                                        
                                        Divider()
                                            .background(.gray)
                                    }
                                    .padding(.bottom, 15)
                                }
                                
                                // Navigate to Privacy Policy Page
                                NavigationLink (destination: AboutUs()) {
                                    VStack {
                                        HStack {
                                            Text("About Us")
                                                .font(.title3)
                                                .bold()
                                                .foregroundColor(isDarkMode ? Color.white : Color.black)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "arrow.right")
                                                .foregroundColor(isDarkMode ? Color.white : Color.black)
                                        }
                                        .padding(.bottom, 15)
                                        
                                        Divider()
                                            .background(.gray)
                                    }
                                    .padding(.bottom, 15)
                                }
                                
                                // Dark / Light Mode
                                VStack {
                                    HStack {
                                        Text("Dark Theme")
                                            .font(.title3)
                                            .bold()
                                            .foregroundColor(isDarkMode ? Color.white : Color.black)
                                        
                                        Spacer()
                                        
                                        Button {
                                            isDarkMode.toggle()
                                        } label: {
                                            
                                            Image(systemName: isDarkMode ? "moon.circle.fill" : "sun.max.circle")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(isDarkMode ? Color("Neon") : .black)
                                                .frame(width: 30)
                                        }
                                        
                                    }
                                    .padding(.bottom, 15)
                                    
                                    Divider()
                                        .background(.gray)
                                }
                                .padding(.bottom, 15)
                                
                                Spacer()
                                
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
                            .frame(maxHeight: UIScreen.main.bounds.height, alignment: .top)
                            .frame(width: 330)
                        }
                        // MARK: Hide default Back Button
                        .navigationBarBackButtonHidden(true)
                    }
                    .frame(maxHeight: UIScreen.main.bounds.height, alignment: .top)
                }
                .preferredColorScheme(isDarkMode ? .dark : .light)
                
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
