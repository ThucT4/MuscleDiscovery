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

/// Describe input text field
struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    let isSecuredField: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .foregroundColor(Color("Neon"))
                .fontWeight(.semibold)
                .font(.footnote)
            
            // If field is used for normal text input or password input
            if isSecuredField {
                SecureField("password", text: $text)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
                
            Divider()
        } // VStack
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Email", placeholder: "john.doe@hotmail.com", isSecuredField: false)
    }
}
