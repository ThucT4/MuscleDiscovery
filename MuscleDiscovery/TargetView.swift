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

struct TargetView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    var name: String
    var current: CGFloat
    var max: CGFloat
    
    // MARK: This components constructed to show the information of current carbs, fat and protein of all meals
    
    var body: some View {
        
        // MARK: Main VStack for background
        VStack(){
            
            Text(name)
                .bold()
            
            ProgressView(value: Float(current),
                         total: Float(max))
            .tint(Color("Neon"))
            .scaleEffect(x: 1, y: 2, anchor: .center)
            .padding(.horizontal, 20)
            
            Text("\(current, specifier: "%.0f")")
                .bold()
                .foregroundColor(current > max ? Color(red: 0.70, green: 0.23, blue: 0.23) : isDarkMode ? .white : .black)
            + Text("/\(max, specifier: "%.0f")")
                .bold()
            
        }//end of VStack
    }
}

struct TargetView_Previews: PreviewProvider {
    static var previews: some View {
        TargetView(name: "Protein", current: 23.0, max: 230.0)
            .preferredColorScheme(.dark)
    }
}

