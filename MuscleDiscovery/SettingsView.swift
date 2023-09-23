/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2023B
    Assessment: Assignment 3
    Author: Lai Nghiep Tri, Thieu Tran Tri Thuc, Truong Bach Minh, Vo Thanh Thong
    ID: s3799602, s3870730, s3891909, s3878071
    Created  date: 12/9/2023
    Last modified: 25/9/2023
    Acknowledgement:
        - The UI designs are inspired from:
            “Gym fitness app ui kit: Figma community,” Figma, https://www.figma.com/community/file/1096744662320428503 (accessed Sep. 12, 2023).
 */

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
                .fill(Color("Dark grey"))
                .frame(height: 30)
                .overlay(alignment: .center, content: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(isDarkMode ? .white : .black)
                    
                })
                .modifier(Shadown3DModifier())
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
                                    
                                    
                                    AsyncImage(url: imageURL) {image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 110, height: 110)
                                            .clipShape(Circle())
                                    } placeholder: {
                                        ProgressView()
                                            .tint(Color("Neon"))
                                    }
                                }
                                .padding(.trailing, 40)
                                
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
                                
                                // Navigate to About Us View
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
                                
                                // Dark / Light Mode Button
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
                .navigationViewStyle(StackNavigationViewStyle())
                .preferredColorScheme(isDarkMode ? .dark : .light)
                
            }
        }
    }
}
