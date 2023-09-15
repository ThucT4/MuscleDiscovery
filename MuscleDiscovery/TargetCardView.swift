//
//  TargetCardView.swift
//  RMIT-Hackathon-Workout
//
//  Created by Minh Trương on 13/09/2023.
//

import SwiftUI

struct TargetCardView: View {
    var Foods: [Food]
    var type: String
    var imageName: String
    
    private var imageURL: URL {
        return URL(string: imageName)!
    }
    
    @State private var foodListName: [String] = [String]()
    @State private var isPresented = false
    
    //passing data between screens
    @Binding var selectionList: [Food]
    @State private var singleSelectionList: [Food] = [Food]()
    var body: some View {
        VStack(){
            HStack(){
                AsyncImage(url: imageURL) {image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .padding(.horizontal, 10)
                } placeholder: {
                    
                }
                .frame(width: 80, height: 80)
                VStack(alignment: .leading){
                    Text(type)
                        .bold()
                        .font(.headline)
                    Text((foodListName.count == 0) ? "1/3 kcal of aim" : foodListName.joined(separator: ", "))
                        .lineLimit(1)
                        .font(.subheadline)
                }
                Spacer()
                Button() {
                    isPresented.toggle()
                } label: {
                    Text(Image(systemName: "plus"))
                        .font(.system(size: 24))
                        .padding(.all, 12)
                        .bold()
                        .foregroundColor(.white)
                        .background(ColorConstant.luminousGreen.opacity(0.7))
                        .clipShape(Circle())
                }
                .fullScreenCover(isPresented: $isPresented){
                    FoodListView(FoodData: Foods, selectionList: $selectionList, singleSelectionList: $singleSelectionList)
                }
            }

            if(foodListName.count != 0){
                Divider()
                    .background(ColorConstant.textWarning)
                Text("\(calculateAllCalo(singleSelectionList), specifier: "%.1f") kcal")
                    .foregroundColor(ColorConstant.luminousGreen)
                    .bold()
            }

        }
        .frame(maxWidth: .infinity)
        .padding(.all, 20)
        .background(ColorConstant.gray)
        .cornerRadius(15)
        .onChange(of: singleSelectionList){newValue in
            self.foodListName = [String]()
            for i in 0..<singleSelectionList.count{
                foodListName.append(singleSelectionList[i].name)
            }
        }
    }
    func calculateAllCalo(_ foodList: [Food]) -> CGFloat {
        var total: CGFloat = 0.0
        for i in 0..<foodList.count{
            total += foodList[i].calo
        }
        return total
    }
}


//
//struct TargetCardView_Previews: PreviewProvider {
//    @State private var selectionList: [Food] = [Food]()
//    static var previews: some View {
//        TargetCardView(type: "Breakfast", imageName: "meal1", selectionList: $selectionList)
//            .preferredColorScheme(.dark)
//    }
//}

