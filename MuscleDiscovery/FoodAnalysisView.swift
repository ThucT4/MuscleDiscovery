//
//  FoodAnalysisView.swift
//  RMIT-Hackathon-Workout
//
//  Created by Minh Trương on 13/09/2023.
//

import SwiftUI

var aimedCalo: [CGFloat] = [300, 400, 500, 600, 700, 800, 900, 1000, 1250, 1500, 1750, 2000, 2500, 3000]

var imageIconUrl = ["https://firebasestorage.googleapis.com/v0/b/muscledicovery.appspot.com/o/meal1.png?alt=media&token=98441881-9290-453d-81a9-53c292ae9f7f", "https://firebasestorage.googleapis.com/v0/b/muscledicovery.appspot.com/o/meal2.png?alt=media&token=2d73c87e-aa12-4da5-b2e7-0b6e57f0e27c", "https://firebasestorage.googleapis.com/v0/b/muscledicovery.appspot.com/o/meal3.png?alt=media&token=37d4b99a-80f7-486d-9eed-997e2106e9ed"]

struct FoodAnalysisView: View {
    @StateObject var foodListModel = FoodListViewModel()
    
    @State private var progress = 0.0
    private var date = Date()
    
    @State private var selectionList: [Food] = [Food]()
    @State private var targetCalo: CGFloat = 1000
    @State private var currentCarbs: CGFloat = 0.0
    @State private var currentProtein: CGFloat = 0.0
    @State private var currentFat: CGFloat = 0.0
    @State private var showPicker: Bool = false
    var body: some View {
        ZStack(){
            ScrollView {
                VStack(spacing: 20){
                    Button{
                        self.showPicker = true
                    } label: {
                        HStack(){
                            Text(Image(systemName: "figure.gymnastics"))
                                .font(.system(size: 12))
                            Text("Choose target")
                        }
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(ColorConstant.luminousGreen)
                    }
                    
                    if(showPicker){
                        Picker(selection: $targetCalo, label: EmptyView()) {
                            ForEach(aimedCalo, id: \.self) {value in
                                 Text("\(value, specifier: "%.0f")")
                             }
                        }
                        .pickerStyle(.wheel)
                        .onChange(of: targetCalo){newValue in
                            self.showPicker = false
                        }
                    }
                    HStack(){
                        VStack(){
                            Text("\(calculateAllCalo(selectionList), specifier: "%.1f")")
                            Text("Eaten")
                        }
                        .padding(.trailing, 10)
                        .textCase(.uppercase)
                        .bold()
                        .font(.headline)
                        CircleProgressView(progress: progress, targetCalo: targetCalo-calculateAllCalo(selectionList))
                            .frame(width: 200, height: .infinity)
                        VStack(){
                            Text("0")
                            Text("Burn")
                        }
                        .padding(.leading, 10)
                        .textCase(.uppercase)
                        .bold()
                        .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    HStack(){
                        TargetView(name: "Carbs", current: currentCarbs, max: targetCalo*0.1)
                        TargetView(name: "Protein", current: currentProtein, max: targetCalo*0.075)
                        TargetView(name: "Fat", current: currentFat, max: targetCalo*0.03)
                    }
                    .padding(.vertical, 20)
                    .background(ColorConstant.gray)
                    .cornerRadius(15)
                    HStack(){
                        Image(systemName: "calendar")
                        Text("TODAY ")
                        Text("\(date.formatted(.dateTime.day().month().year()))").textCase(.uppercase)
                    }
                    TargetCardView(Foods: foodListModel.foodList, type: "Breakfast", imageName: imageIconUrl[0], selectionList: $selectionList)
                    TargetCardView(Foods: foodListModel.foodList, type: "Lunch", imageName: imageIconUrl[1], selectionList: $selectionList)
                    TargetCardView(Foods: foodListModel.foodList, type: "Dinner", imageName: imageIconUrl[2], selectionList: $selectionList)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .preferredColorScheme(.dark)
        .onChange(of: selectionList){newValue in
            self.progress = calculateAllCalo(selectionList)/targetCalo*100
            self.currentCarbs = calculateAllCarbs(selectionList)
            self.currentProtein = calculateAllProtein(selectionList)
            self.currentFat = calculateAllFat(selectionList)
        }
    }
    func calculateAllCalo(_ foodList: [Food]) -> CGFloat {
        var total: CGFloat = 0.0
        for i in 0..<foodList.count{
            total += foodList[i].calo
        }
        return total
    }
    
    func calculateAllCarbs(_ foodList: [Food]) -> CGFloat {
        var total: CGFloat = 0.0
        for i in 0..<foodList.count{
            total += foodList[i].carbs
        }
        return total
    }
    func calculateAllProtein(_ foodList: [Food]) -> CGFloat {
        var total: CGFloat = 0.0
        for i in 0..<foodList.count{
            total += foodList[i].protein
        }
        return total
    }
    func calculateAllFat(_ foodList: [Food]) -> CGFloat {
        var total: CGFloat = 0.0
        for i in 0..<foodList.count{
            total += foodList[i].fat
        }
        return total
    }
}

struct FoodAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        FoodAnalysisView()
    }
}

