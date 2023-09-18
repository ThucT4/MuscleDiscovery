//
//  EditProfileView.swift
//  MuscleDiscovery
//
//  Created by Vo Thanh Thong on 15/09/2023.
//

import SwiftUI

struct EditProfileView: View {
    
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
            ColorConstant.black
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                // Profile Image and Button
                ZStack {
                    Image("Profile-Picture")
                        .resizable()
                        .frame(width: 120, height: 120)
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .fill(Color.gray) // Fill color of the circle
                                    .frame(width: 46, height: 46) // Size of the circle
                                Image(systemName: "camera.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 23)
                                    .foregroundColor(Color.white)
                            }
                            
                        }
                        
                    }
                    .frame(width: 130, height: 130)
                    
                }
                .padding(.bottom, 50)
                
                // MARK: Information
                // Name
                VStack (alignment: .leading) {
                    Divider()
                        .background(Color.gray)
                        .padding(.bottom, 10)
                    
                    Text("Name")
                        .foregroundColor(ColorConstant.luminousGreen)
                        .padding(.bottom, 5)
                        .padding(.horizontal)
                    Text("Sarah Wegan")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(.bottom, 15)
                        .padding(.horizontal)
                    
                    Divider()
                        .background(Color.gray)
                }
                .padding(.bottom, 10)
                
                // Age
                VStack (alignment: .leading) {
                    Text("Age")
                        .foregroundColor(ColorConstant.luminousGreen)
                        .padding(.bottom, 5)
                        .padding(.horizontal)
                    Text("23")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.bottom, 15)
                        .padding(.horizontal)
                    
                    Divider()
                        .background(Color.gray)
                }
                .padding(.bottom, 10)
                
                // Height
                VStack (alignment: .leading) {
                    Text("Height")
                        .foregroundColor(ColorConstant.luminousGreen)
                        .padding(.bottom, 5)
                        .padding(.horizontal)
                    Text("174 cm")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(.bottom, 15)
                        .padding(.horizontal)
                    
                    Divider()
                        .background(Color.gray)
                }
                .padding(.bottom, 10)
                
                // Weight
                VStack (alignment: .leading) {
                    Text("Weight")
                        .foregroundColor(ColorConstant.luminousGreen)
                        .padding(.bottom, 5)
                        .padding(.horizontal)
                    Text("74 kg")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(.bottom, 15)
                        .padding(.horizontal)
                    
                    Divider()
                        .background(Color.gray)
                }
                .padding(.bottom, 10)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Save")
                        .foregroundColor(Color.black)
                        .bold()
                        .frame(width: 260, height: 50)
                        .background(ColorConstant.luminousGreen)
                        .cornerRadius(50)
                        .padding(.bottom, 30)
                }
            }
            .frame(width: 330)
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

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
