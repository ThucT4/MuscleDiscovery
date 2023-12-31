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
import WrappingHStack

var badgeItems = ["Italian", "FastFood", "Japanese", "Vegan", "American", "Snack", "Chicken", "Fruit", "Egypt"]

struct FoodListView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
    @Environment(\.dismiss) var dismiss
    
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
                dismiss()
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
        
        // MARK: Main navigation View
        NavigationView(){
            
            // MARK: Main ZStack for background
            ZStack {
                
                Color("Background")
                    .ignoresSafeArea(.all)
                // MARK: Main List for display items
                List {
                    
                    // MARK: WrappingHStack to display item in the next line when overflowing
                    WrappingHStack(badgeItems, id: \.self){ item in
                            Button {
                                if(filtered == item){
                                    filtered = ""
                                }
                                else{
                                    filtered = item
                                }
                            } label: {
                                Text(item)
                                    .padding(.all, 3)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color("Neon"), lineWidth: 1)
                                    )
                                    .background((filtered == item) ? Color("Neon") : Color("Dark grey"))
                            }
                            .padding(3)
                            .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.bottom, 10)
                    
                    // MARK: LazyVStack help to load the FoodRowView
                        ForEach(searchingResult) {item in
                            HStack(spacing: 0) {
                                FoodRowView(FoodItem: item)
                                    .modifier(Shadown3DModifier())
                                
                                NavigationLink(destination: FoodDetailView(FoodItem: item, selectionList: $selectionList, singleSelectionList: $singleSelectionList)) {
                                    FoodDetailView(FoodItem: item, selectionList: $selectionList, singleSelectionList: $singleSelectionList)
                                }
                                .frame(width: 0, height: 0)
                                .opacity(0)
                            }
                            .padding(.all, 0)
                        }
                    
                } //end of list
                .listRowSeparator(.hidden)
                .listStyle(PlainListStyle())
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    
                    ToolbarItem(placement: .principal) {
                        
                        HStack (spacing: 20) {
                            backButton

                            Text("FOOD LIST")
                                .font(.system(.title3, weight: .heavy))
                            
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    }
                }
                
            }// end ZStack
            
        } // end NavigationView
        .searchable(text: $searchText,
               placement: .navigationBarDrawer(displayMode: .always))

    }
    
    var searchingResult: [Food]{
        if(!searchText.isEmpty && !filtered.isEmpty){
            return FoodData.filter{ $0.name.localizedCaseInsensitiveContains(searchText)}.filter{
                $0.tags.joined(separator: " ").localizedCaseInsensitiveContains(filtered)
            }
        }
        else if (!searchText.isEmpty && filtered.isEmpty){
            return FoodData.filter{ $0.name.localizedCaseInsensitiveContains(searchText)}
        }
        else if(searchText.isEmpty && !filtered.isEmpty){
            return FoodData.filter{$0.tags.joined(separator: "").localizedCaseInsensitiveContains(filtered)}
        }
        return FoodData
    }
}

