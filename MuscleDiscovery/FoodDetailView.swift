//
//  FoodDetailView.swift
//  RMIT-Hackathon-Workout
//
//  Created by Minh Trương on 13/09/2023.
//

import SwiftUI

struct FoodDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var FoodItem: Food
    
    //passing data between screens
    @Binding var selectionList: [Food]
    @Binding var singleSelectionList: [Food]
    
    private var total: CGFloat{
        return FoodItem.carbs + FoodItem.fat + FoodItem.protein
    }
    
    private var imageURL: URL {
        return URL(string: FoodItem.image)!
    }
    
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
        ScrollView {
            ZStack(){
                VStack(alignment: .leading, spacing: 20){
                    AsyncImage(url: imageURL) {image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Rectangle())
                    } placeholder: {
                        
                    }
                    .frame(width: .infinity, height: 200)
                    VStack(alignment: .leading, spacing: 5){
                        Text(FoodItem.name)
                            .font(.system(size: 24))
                            .bold()
                        Text("Calculate the nutrition **per item**")
                            .font(.subheadline)
                    }
                    HStack(spacing: 20){
                        VStack(){
                            CircleProgressView(progress: FoodItem.carbs/total*100, isPercent: true, size: 6.0)
                                .frame(width: 80, height: 80)
                            Text("Carbs")
                                .font(.subheadline)
                        }
                        Spacer()
                        VStack(){
                            CircleProgressView(progress: FoodItem.protein/total*100, isPercent: true, size: 6.0)
                                .frame(width: 80, height: 80)
                            Text("Protein")
                                .font(.subheadline)
                        }
                        Spacer()
                        VStack(){
                            CircleProgressView(progress: FoodItem.fat/total*100, isPercent: true, size: 6.0)
                                .frame(width: 80, height: 80)
                            Text("Fat")
                                .font(.subheadline)
                        }
                    }
                    VStack(){
                        Divider()
                            .background(ColorConstant.luminousGreen)
                        HStack(){
                            Text("Calories")
                                .font(.system(size: 24))
                                .bold()
                            Spacer()
                            Text("\(FoodItem.calo, specifier: "%.1f") cal")
                                .font(.system(size: 24))
                                .bold()
                        }
                        Divider()
                            .background(ColorConstant.luminousGreen)
                        HStack(){
                            Text("Carbs")
                                .font(.system(size: 24))
                                .bold()
                            Spacer()
                            Text("\(FoodItem.carbs, specifier: "%.1f") g")
                                .font(.system(size: 24))
                                .bold()
                        }
                        Divider()
                            .background(ColorConstant.luminousGreen)
                        HStack(){
                            Text("Protein")
                                .font(.system(size: 24))
                                .bold()
                            Spacer()
                            Text("\(FoodItem.protein, specifier: "%.1f") g")
                                .font(.system(size: 24))
                                .bold()
                        }
                        Divider()
                            .background(ColorConstant.luminousGreen)
                        HStack(){
                            Text("Fat")
                                .font(.system(size: 24))
                                .bold()
                            Spacer()
                            Text("\(FoodItem.fat, specifier: "%.1f") g")
                                .font(.system(size: 24))
                                .bold()
                        }
                    }
                    VStack(){
                        if(isItemInTheList(FoodItem)){
                            Button{
                                self.removeItemFromList(FoodItem)
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                Rectangle()
                                    .fill(ColorConstant.luminousGreen)
                                    .frame(width: .infinity, height: 50)
                                    .border(.white, width: 4)
                                    .cornerRadius(15)
                                    .overlay(
                                        Text("Remove item")
                                            .bold()
                                            .textCase(.uppercase)
                                            .foregroundColor(ColorConstant.black)
                                    )
                            }
                        }else{
                            Button{
                                self.addItemToList(FoodItem)
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                Rectangle()
                                    .fill(ColorConstant.luminousGreen)
                                    .frame(width: .infinity, height: 50)
                                    .border(.white, width: 4)
                                    .cornerRadius(15)
                                    .overlay(
                                        Text("Add item")
                                            .bold()
                                            .textCase(.uppercase)
                                            .foregroundColor(ColorConstant.black)
                                    )
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle(FoodItem.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack (spacing: 20) {
                        backButton

                        Text("FOOD LIST")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .heavy))
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                }
            }
        }
    }
    func isItemInTheList(_ foodItem: Food) -> Bool {
        if singleSelectionList.firstIndex(where: {$0.id == foodItem.id}) != nil{
            return true;
        }
        return false;
    }
    func addItemToList(_ foodItem: Food) {
        selectionList.append(foodItem)
        singleSelectionList.append(foodItem)
    }
    func removeItemFromList(_ foodItem: Food){
        if let singleFoodIndex = singleSelectionList.firstIndex(where: {$0.id == foodItem.id}){
            singleSelectionList.remove(at: singleFoodIndex)
        }
        if let listFoodIndex = selectionList.firstIndex(where: {$0.id == foodItem.id}){
            selectionList.remove(at: listFoodIndex)
        }
    }
}

//struct FoodDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodDetailView(FoodItem: Foods[0])
//            .preferredColorScheme(.dark)
//    }
//}

