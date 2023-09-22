//
//  SettingsAppView.swift
//  MuscleDiscovery
//
//  Created by Vo Thanh Thong on 15/09/2023.
//

import SwiftUI

//enum Theme {
//    static let darkMode = false
//}

struct SettingsAppView: View {
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
        ZStack {
            
            isDarkMode == true ?
            
            VStack {
                ColorConstant.black
            }
            .ignoresSafeArea()
            :
            VStack {
                Color.white
            }
            .ignoresSafeArea()
            
            VStack {
                Divider()
                    .background(.gray)
                    .padding(.top, 100)
                    .padding(.bottom, 15)
                
                // Option Button
                VStack {
                    HStack {
                        Text("Dark Theme")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button {
                            isDarkMode.toggle()
                        } label: {
                            
                            
                            Image(systemName: isDarkMode == true ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(isDarkMode == true ? ColorConstant.luminousGreen : .white)
                                .frame(width: 30)
                        }
                        
                    }
                    .padding(.bottom, 15)
                    
                    Divider()
                        .background(.gray)
                }
                .padding(.bottom, 15)
                
                Spacer()
                
                VStack {
                    Text("You can manage your app notification permission in your ")
                        .foregroundColor(.white) +
                    Text("Phone Settings")
                        .foregroundColor(ColorConstant.luminousGreen)
                }
                .padding(.bottom, 50)
            }
            .frame(width: 330)
            
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
}

struct SettingsAppView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAppView()
    }
}
