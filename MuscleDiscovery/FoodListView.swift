
//
//  FoodListView.swift
//  RMIT-Hackathon-Workout
//
//  Created by Minh Trương on 13/09/2023.
//

import SwiftUI

var badgeItems = ["Italian", "FastFood", "Japanese", "Vegan", "American", "Snack", "Chicken", "Fruit", "Egypt"]

struct FoodListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
                        .font(.system(size: 15, weight: .medium))
                    
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
                HStack(){
                    ForEach(badgeItems, id: \.self) { item in
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
                                .foregroundColor(!(filtered == item) ? .white : ColorConstant.gray)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(ColorConstant.luminousGreen, lineWidth: 1)
                                )
                                .background((filtered == item) ? ColorConstant.luminousGreen : ColorConstant.gray)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.bottom, 10)
                ForEach(searchingResult) {item in
                    HStack(spacing: 0) {
                        FoodRowView(FoodItem: item)
                        NavigationLink(destination: FoodDetailView(FoodItem: item, selectionList: $selectionList, singleSelectionList: $singleSelectionList)) {
                            FoodDetailView(FoodItem: item, selectionList: $selectionList, singleSelectionList: $singleSelectionList)
                        }
                        .frame(width: 0, height: 0)
                        .opacity(0)
                    }
                    .padding(.all, 0)
                }
            }
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
            .listStyle(PlainListStyle())
            
        }
        .searchable(text: $searchText,
               placement: .navigationBarDrawer(displayMode: .always))
        .preferredColorScheme(.dark)

    }
    
//    var btnBack : some View { Button(action: {
//            self.presentationMode.wrappedValue.dismiss()
//            }) {
//                HStack {
//                Text(Image(systemName: "x.circle"))
//                    .padding(.all, 6)
//                    .bold()
//                    .foregroundColor(.white)
//                    .background(ColorConstant.gray)
//                    .clipShape(Circle())
//                }
//            }
//        }
    
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
//
//struct FoodListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodListView(FoodData: Foods)
//    }
//}
