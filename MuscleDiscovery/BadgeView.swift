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

struct BadgeView: View {
    var tags: [String]
    
    // MARK: This components is constructed to show the badge with its name
    
    var body: some View {
        
        HStack(){
            ForEach(tags, id: \.self){tag in
                
                HStack(spacing: 0){
                    Text(tag)
                        .font(.system(.caption2))
                        .bold()
                        .textCase(.uppercase)
                        .padding(.all, 4)
                }
                .background(Color("Neon"))
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            }
        } //ned of HStack
    }
}


