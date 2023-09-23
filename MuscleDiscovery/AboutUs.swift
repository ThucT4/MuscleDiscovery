//
//  AboutUs.swift
//  MuscleDiscovery
//
//  Created by Vo Thanh Thong on 23/09/2023.
//

import SwiftUI

struct AboutUs: View {
    // Save systemTheme to AppStorage to save user option for the next using and access from other view
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
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
        ZStack {
            // Background Color
            Color("Background")
                .ignoresSafeArea(.all)
            
            VStack{                // Title
                Text("TEAM MEMBER")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                // Members Components
                HStack {
                    // Circle to take space while waiting for image loading
                    Circle()
                        .fill(Color("Dark grey"))
                        .frame(width: 80)
                        .overlay(alignment: .center, content: {
                            Image("Thanh-Thong")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 80)
                        })
                        .padding()
                    
                    VStack (spacing: 10) {
                        Text("Vo Thanh Thong")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Text("Student ID:")
                                .font(.body)
                                .bold()
                            Text("s3878071")
                                .font(.body)
                                .foregroundColor(Color("Neon"))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Text("Major:")
                                .font(.body)
                                .bold()
                            Text("Information Technology")
                                .font(.body)
                                .foregroundColor(Color("Neon"))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                    Spacer()
                    
                } // end Main HStack
                .background(Color("Dark grey"))
                .clipShape(RoundedRectangle(cornerRadius: 20))  // Rounded corner
                
                HStack {
                    // Circle to take space while waiting for image loading
                    Circle()
                        .fill(Color("Dark grey"))
                        .frame(width: 80)
                        .overlay(alignment: .center, content: {
                            Image("Minh-Truong")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 80)
                        })
                        .padding()
                    
                    VStack (spacing: 10) {
                        Text("Truong Bach Minh")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Text("Student ID:")
                                .font(.body)
                                .bold()
                            Text("s3891909")
                                .font(.body)
                                .foregroundColor(Color("Neon"))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Text("Major:")
                                .font(.body)
                                .bold()
                            Text("Information Technology")
                                .font(.body)
                                .foregroundColor(Color("Neon"))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                    Spacer()
                    
                } // end Main HStack
                .background(Color("Dark grey"))
                .clipShape(RoundedRectangle(cornerRadius: 20))  // Rounded corner
                
                HStack {
                    // Circle to take space while waiting for image loading
                    Circle()
                        .fill(Color("Dark grey"))
                        .frame(width: 80)
                        .overlay(alignment: .center, content: {
                            Image("Tri-Lai")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 80)
                        })
                        .padding()
                    
                    VStack (spacing: 10) {
                        Text("Lai Nghiep Tri")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Text("Student ID:")
                                .font(.body)
                                .bold()
                            Text("s3799602")
                                .font(.body)
                                .foregroundColor(Color("Neon"))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Text("Major:")
                                .font(.body)
                                .bold()
                            Text("Software Engineering")
                                .font(.body)
                                .foregroundColor(Color("Neon"))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                    Spacer()
                    
                } // end Main HStack
                .background(Color("Dark grey"))
                .clipShape(RoundedRectangle(cornerRadius: 20))  // Rounded corner
                
                HStack {
                    // Circle to take space while waiting for image loading
                    Circle()
                        .fill(Color("Dark grey"))
                        .frame(width: 80)
                        .overlay(alignment: .center, content: {
                            Image("Thieu-Thuc")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 80)
                        })
                        .padding()
                    
                    VStack (spacing: 10) {
                        Text("Thieu Tran Tri Thuc")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Text("Student ID:")
                                .font(.body)
                                .bold()
                            Text("s3870730")
                                .font(.body)
                                .foregroundColor(Color("Neon"))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Text("Major:")
                                .font(.body)
                                .bold()
                            Text("Software Engineering")
                                .font(.body)
                                .foregroundColor(Color("Neon"))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                    Spacer()
                    
                } // end Main HStack
                .background(Color("Dark grey"))
                .clipShape(RoundedRectangle(cornerRadius: 20))  // Rounded corner
                
                Spacer()
            }
            .padding(.horizontal, 10)
        }
        // MARK: Hide default Back Button
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack (spacing: 20) {
                    backButton
                }
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
            }
        }
    }
}

struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs()
    }
}
