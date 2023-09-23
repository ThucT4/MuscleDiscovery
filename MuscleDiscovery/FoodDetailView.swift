//
//  FoodDetailView.swift
//  RMIT-Hackathon-Workout
//
//  Created by Minh Trương on 13/09/2023.
//

import SwiftUI

struct FoodDetailView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
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
    
    @State var targetCalo: CGFloat = 0.0
    
    // MARK: Cutomer back button for view
    var backButton: some View {
        Button(action: {
            withAnimation() {
                self.presentationMode.wrappedValue.dismiss()
            }
        })  {
            Circle()
                .fill(Color("Dark grey"))
                .frame(height: 30)
                .overlay(alignment: .center, content: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(isDarkMode ? .white : .black)
                    
                })
                .modifier(Shadown3DModifier())
        }
        .contentShape(Circle())
    }
    
    var body: some View {
        // MARK: Main ZStack for background
        ZStack {
            Color("Background")
                .ignoresSafeArea(.all)
            // MARK: Main ScrollView to display information
            ScrollView {
                ZStack(){
                    VStack(alignment: .leading, spacing: 20){
                        // MARK: Food Image
                        AsyncImage(url: imageURL) {image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipShape(Rectangle())
                                .padding(.bottom, 20)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: UIScreen.main.bounds.width*0.8, height: 200, alignment: .center)
                        // MARK: Food information
                        VStack(alignment: .leading, spacing: 5){
                            Text(FoodItem.name)
                                .font(.system(.title3))
                                .bold()
                            
                            Text(FoodItem.description)
                                .font(.system(.body))
                                .fontWeight(.medium)
                            
                            Text("Calculate the nutrition **per item**")
                                .padding(.top, 20)
                                .font(.system(.title3))
                                .bold()
                        }
                        // MARK: Food nutrition information and calculation
                        HStack(spacing: 20){
                            VStack(){
                                CircleProgressView(progress: FoodItem.carbs/total*100, isPercent: true, size: 6.0, targetCalo: $targetCalo)
                                    .frame(width: 80, height: 80)
                                Text("Carbs")
                                    .font(.subheadline)
                            }
                            Spacer()
                            VStack(){
                                CircleProgressView(progress: FoodItem.protein/total*100, isPercent: true, size: 6.0, targetCalo: $targetCalo)
                                    .frame(width: 80, height: 80)
                                Text("Protein")
                                    .font(.subheadline)
                            }
                            Spacer()
                            VStack(){
                                CircleProgressView(progress: FoodItem.fat/total*100, isPercent: true, size: 6.0, targetCalo: $targetCalo)
                                    .frame(width: 80, height: 80)
                                Text("Fat")
                                    .font(.subheadline)
                            }
                        }
                        VStack(){
                            Divider()
                                .background(Color("Neon"))
                            
                            HStack(){
                                Text("Calories")
                                    .font(.system(.title3))
                                    .bold()
                                
                                Spacer()
                                
                                Text("\(FoodItem.calo, specifier: "%.1f") cal")
                                    .font(.system(.title3))
                                    .bold()
                            }
                            
                            Divider()
                                .background(Color("Neon"))
                            
                            HStack(){
                                Text("Carbs")
                                    .font(.system(.title3))
                                    .bold()
                                
                                Spacer()
                                
                                Text("\(FoodItem.carbs, specifier: "%.1f") g")
                                    .font(.system(.title3))
                                    .bold()
                            }
                            
                            Divider()
                                .background(Color("Neon"))
                            
                            HStack(){
                                Text("Protein")
                                    .font(.system(.title3))
                                    .bold()
                                
                                Spacer()
                                
                                Text("\(FoodItem.protein, specifier: "%.1f") g")
                                    .font(.system(.title3))
                                    .bold()
                            }
                            
                            Divider()
                                .background(Color("Neon"))
                            
                            HStack(){
                                Text("Fat")
                                    .font(.system(.title3))
                                    .bold()
                                
                                Spacer()
                                
                                Text("\(FoodItem.fat, specifier: "%.1f") g")
                                    .font(.system(.title3))
                                    .bold()
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.trailing)
                }
                .padding(.top)
                .navigationTitle(FoodItem.name)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack (spacing: 20) {
                            backButton
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    }
                }
                // MARK: Action to specific item (Add or Remove)
                VStack(){
                    Button{
                        if(isItemInTheList(FoodItem)){
                            self.removeItemFromList(FoodItem)
                        }
                        else{
                            self.addItemToList(FoodItem)
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Rectangle()
                            .fill(Color("Neon"))
                            .frame(width: UIScreen.main.bounds.width*0.7, height: 50)
                            .border(.white, width: 4)
                            .cornerRadius(15)
                            .overlay(
                                Text("\( isItemInTheList(FoodItem) ? "Remove item" : "Add item")")
                                    .bold()
                                    .textCase(.uppercase)
                                    .foregroundColor(.black)
                            )
                            .modifier(Shadown3DModifier())
                    }
                }
                .frame(maxHeight: UIScreen.main.bounds.height, alignment: .bottom)
            }
        }
    }
    // MARK: End of ZStack
    
    // MARK: List of functions
    func isItemInTheList(_ foodItem: Food) -> Bool {
        // Return bool to check if item in the list
        if singleSelectionList.firstIndex(where: {$0.id == foodItem.id}) != nil{
            return true;
        }
        return false;
    }
    // add the item to the current meal list and whole selection list
    func addItemToList(_ foodItem: Food) {
        selectionList.append(foodItem)
        singleSelectionList.append(foodItem)
    }
    // remove the item to the current meal list and whole selection list
    func removeItemFromList(_ foodItem: Food){
        if let singleFoodIndex = singleSelectionList.firstIndex(where: {$0.id == foodItem.id}){
            singleSelectionList.remove(at: singleFoodIndex)
        }
        if let listFoodIndex = selectionList.firstIndex(where: {$0.id == foodItem.id}){
            selectionList.remove(at: listFoodIndex)
        }
    }
}


