//
//  TargetCardView.swift
//  RMIT-Hackathon-Workout
//
//  Created by Minh Trương on 13/09/2023.
//

import SwiftUI

struct TargetCardView: View {
    @StateObject var Foods = FoodListViewModel()
    var type: String
    var imageName: String
    
    @State private var foodListName: [String] = [String]()
    @State private var isPresented = false
    @State private var showInventory = false
    
    //passing data between screens
    @Binding var selectionList: [Food]
    @Binding var showPicker: Bool
    @State private var singleSelectionList: [Food] = [Food]()
    
    // MARK: This component constructed to display the current information of breakfast, lunch and dinner including add/remove food
    
    var body: some View {
        // MARK: Main VStack
        VStack(){
            // MARK: Display the icon of meal
            HStack(){
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .padding(.horizontal, 10)
                        .frame(width: 80, height: 80)
                VStack(alignment: .leading){
                    Text(type)
                        .bold()
                        .font(.headline)
                    Text((foodListName.count == 0) ? "1/3 cal of aim" : foodListName.joined(separator: ", "))
                        .lineLimit(1)
                        .font(.subheadline)
                }
                Spacer()
                // MARK: Show the button to navigate to add/remove food list
                Button() {
                    isPresented.toggle()
                    if(showPicker){
                       showPicker = false
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .padding(.all, 12)
                        .bold()
                        .foregroundColor(.white)
                        .background(ColorConstant.luminousGreen.opacity(0.7))
                        .clipShape(Circle())
                }
                .fullScreenCover(isPresented: $isPresented){
                    FoodListView(FoodData: Foods.foodList, selectionList: $selectionList, singleSelectionList: $singleSelectionList)
                }
            }
            // MARK: Show the calories calculation if there is at least one food item in the whole list
            if(foodListName.count != 0){
                VStack{
                    Divider()
                        .background(ColorConstant.textWarning)
                    Text("\(calculateAllCalo(singleSelectionList), specifier: "%.1f") cal")
                        .foregroundColor(Color("Neon"))
                        .bold()
                }
                .onTapGesture {
                    self.showInventory = true
                }
                .fullScreenCover(isPresented: $showInventory){
                    FoodInventoryView(type: type,FoodData: Foods.foodList, selectionList: $selectionList, singleSelectionList: $singleSelectionList)
                }
            }

        }
        .frame(maxWidth: .infinity)
        .padding(.all, 20)
        .background(Color("Dark grey"))
        .cornerRadius(15)
        .onChange(of: singleSelectionList){newValue in
            self.foodListName = [String]()
            for i in 0..<singleSelectionList.count{
                foodListName.append(singleSelectionList[i].name)
            }
        }//end of VStack
    }
    // MARK: Function to calculate the current calories based on added/removed food
    func calculateAllCalo(_ foodList: [Food]) -> CGFloat {
        var total: CGFloat = 0.0
        for i in 0..<foodList.count{
            total += foodList[i].calo
        }
        return total
    }
}


