//
//  PrivacyPolicyView.swift
//  MuscleDiscovery
//
//  Created by Vo Thanh Thong on 15/09/2023.
//

import SwiftUI

struct PrivacyPolicyView: View {
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
            ScrollView (showsIndicators: false) {
                VStack (alignment: .leading) {
                    Text("Lorem ipsum dolor sit amet")
                        .bold()
                        .padding(.bottom)
                        .foregroundColor(.white)
                    
                    Text("Consectetur adipiscing elit. Natoque phasellus lobortis mattis cursus faucibus hac proin risus. Turpis phasellus massa ullamcorper volutpat. Ornare commodo non integer fermentum nisi, morbi id. Vel tortor mauris feugiat amet, maecenas facilisis risus, in faucibus. Vestibulum ullamcorper fames eget enim diam fames faucibus duis ac. Aliquam non tellus semper in dignissim nascetur venenatis lacus.")
                        .padding(.bottom)
                        .foregroundColor(ColorConstant.textGray)
                    
                    Text("Lectus vel non varius interdum vel tellus sed mattis. Sit laoreet auctor arcu mauris tincidunt sociis tristique pharetra neque. Aliquam pharetra elementum nisl sapien. Erat nisl morbi eu dolor in. Sapien ut lacus dui libero morbi tristique.")
                        .padding(.bottom)
                        .foregroundColor(ColorConstant.textGray)
                    
                    Text("Sit praesent mi, dolor, magna in pellentesque sollicitudin odio sed. Sit nibh aliquam enim ipsum lectus sem fermentum congue velit. Purus habitant odio in morbi aliquet velit pulvinar. Facilisis ut amet interdum pretium. Fames pretium eget orci facilisis mattis est libero facilisis ullamcorper. Est auctor amet egestas risus libero et. Auctor faucibus sit id fringilla vitae. Ac volutpat sodales tristique ut netus turpis.")
                        .padding(.bottom)
                        .foregroundColor(ColorConstant.textGray)
                    
                    Text("Lectus vel non varius interdum vel tellus sed mattis. Sit laoreet auctor arcu mauris tincidunt sociis tristique pharetra neque. Aliquam pharetra elementum nisl sapien. Erat nisl morbi eu dolor in. Sapien ut lacus dui libero morbi tristique.")
                        .padding(.bottom)
                        .foregroundColor(ColorConstant.textGray)
                }
                .frame(width: 330)
            }
            .padding(.top, 100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill the entire screen
        .background(ColorConstant.black)
        .ignoresSafeArea()
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

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
