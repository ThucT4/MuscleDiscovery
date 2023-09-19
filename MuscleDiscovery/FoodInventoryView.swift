//
//  FoodInventoryView.swift
//  MuscleDiscovery
//
//  Created by Minh Trương on 19/09/2023.
//

import SwiftUI
import WrappingHStack

struct FoodInventoryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var type: String
    var FoodData: [Food]
    @State private var searchText = ""
    @State private var isDark = false
    @State private var filtered = ""
    
    //passing data between screens
    @Binding var selectionList: [Food]
    @Binding var singleSelectionList: [Food]
    
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
                        .font(.system(.caption2, weight: .medium))
                    
                })
                .foregroundColor(.black)
                .shadow(color: Color("BlackTransparent"), radius: 7)
        }
        .contentShape(Circle())
        .padding(.trailing, 20)
    }
    
    var body: some View {
        NavigationView(){
            List {
                ForEach(searchingResult) {item in
                    HStack(spacing: 0) {
                        FoodRowView(FoodItem: item)
                        Button{
                            removeItemFromList(item)
                        } label: {
                            Image(systemName: "minus")
                                .font(.title3)
                                .padding(.all, 12)
                                .bold()
                                .foregroundColor(.white)
                                .background(ColorConstant.luminousGreen.opacity(0.7))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.all, 0)
                }
            }
            .listRowSeparator(.hidden)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack (spacing: 20) {
                        backButton

                        Text(type)
                            .textCase(.uppercase)
                            .foregroundColor(.white)
                            .font(.system(.title3, weight: .heavy))
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                }
            }
            .listStyle(PlainListStyle())
            
        }
        .searchable(text: $searchText,
               placement: .navigationBarDrawer(displayMode: .always))
        .preferredColorScheme(.dark)

    }
    
    var searchingResult: [Food]{
        if (!searchText.isEmpty){
            return singleSelectionList.filter{ $0.name.localizedCaseInsensitiveContains(searchText)}
        }
        return singleSelectionList
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

