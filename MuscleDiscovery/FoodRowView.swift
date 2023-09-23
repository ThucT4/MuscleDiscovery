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

struct FoodRowView: View {
    var FoodItem: Food
    
    private var imageURL: URL {
        return URL(string: FoodItem.image)!
    }
    
    @State private var currentUrl: URL?
    
    // MARK: This component is constructed to show the food row list in the whole list view
    
    var body: some View {
        
        // MARK: Main HStack
        HStack(spacing: 40){
            
            // MARK: Show the food image that fetched from firebase
            AsyncImage(url: currentUrl) {image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(.leading, 10)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .padding(.leading)
            .onAppear {
                if currentUrl == nil {
                    DispatchQueue.main.async {
                        currentUrl = imageURL
                    }
                }
            }
            
            // MARK: Show the brief information of the specific food item
            VStack(alignment: .leading, spacing: 8){
                
                VStack(alignment: .leading){
                    Text(FoodItem.name)
                        .bold()
                    Text(Image(systemName: "figure.gymnastics"))
                        .font(.caption2)
                        .bold()
                    + Text("\(FoodItem.calo, specifier: "%.1f") kcal")
                        .font(.caption2)
                        .bold()
                }
                
                // MARK: Show all the badges of the current item
                HStack(){
                    BadgeView(tags: FoodItem.tags)
                }
                
            }
            .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)
        .background(Color("Dark grey"))
        .cornerRadius(20)
        
        //end of HStack
    }
}


