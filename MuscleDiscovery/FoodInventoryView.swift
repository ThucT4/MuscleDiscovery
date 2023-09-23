//
//  FoodInventoryView.swift
//  MuscleDiscovery
//
//  Created by Minh Trương on 19/09/2023.
//

import SwiftUI
import WrappingHStack

struct FoodInventoryView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var type: String
    var FoodData: [Food]
    @State private var searchText = ""
    @State private var isDark = false
    @State private var filtered = ""
    
    //passing data between screens
    @Binding var selectionList: [Food]
    @Binding var singleSelectionList: [Food]
    
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
        NavigationView(){
            // MARK: Main ZStack for background
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                // MARK: Main List for display item
                List {
                    ForEach(searchingResult) {item in
                        HStack(spacing: 0) {
                            FoodRowView(FoodItem: item)
                            // MARK: Button to remove item from current list
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
                        .listRowBackground(Color("Background"))
                        .listRowSeparator(.hidden)
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
                                .font(.system(.title3, weight: .heavy))
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    }
                }
                .listStyle(PlainListStyle())
                // MARK: End of Main List
            }
            
        }
        .searchable(text: $searchText,
               placement: .navigationBarDrawer(displayMode: .always))

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


