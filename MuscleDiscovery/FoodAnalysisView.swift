//
//  FoodAnalysisView.swift
//  RMIT-Hackathon-Workout
//
//  Created by Minh Trương on 13/09/2023.
//

import SwiftUI

var aimedCalo: [CGFloat] = [300, 400, 500, 600, 700, 800, 900, 1000, 1250, 1500, 1750, 2000, 2500, 3000]

struct FoodAnalysisView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
    @State private var progress = 0.0
    private var date = Date()
    
    @State private var selectionList: [Food] = [Food]()
    @State private var targetCalo: CGFloat = 1000
    @State private var currentCarbs: CGFloat = 0.0
    @State private var currentProtein: CGFloat = 0.0
    @State private var currentFat: CGFloat = 0.0
    @State private var showPicker: Bool = false
    @State private var eatenCalo: CGFloat = 0.0
    var body: some View {
        // MARK: Main ZStack for background
        ZStack(){
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            // MARK: Main ScrollVIew to display content
            ScrollView {
                VStack(spacing: 20){
                    Button{
                        self.showPicker = true
                    } label: {
                        HStack(){
                            Text(Image(systemName: "figure.gymnastics"))
                                .font(.callout)
                            Text("Choose target")
                        }
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(Color("Neon"))
                    }
                    // MARK: Picker to choose specific calories
                    if(showPicker){
                        Picker(selection: $targetCalo, label: EmptyView()) {
                            ForEach(aimedCalo, id: \.self) {value in
                                 Text("\(value, specifier: "%.0f")")
                             }
                        }
                        .pickerStyle(.wheel)
                        .onChange(of: targetCalo){newValue in
                            self.showPicker = false
                            self.eatenCalo = self.targetCalo-calculateAllCalo(selectionList)
                            self.progress = calculateAllCalo(selectionList)/targetCalo*100
                        }
                    }
                    // MARK: Progress that show how much calos is consumed
                    VStack(){
                        VStack(){
                            Text("\(calculateAllCalo(selectionList), specifier: "%.1f")")
                            Text("Eaten")
                        }
                        .padding(.bottom, 10)
                        .textCase(.uppercase)
                        .bold()
                        .font(.headline)
                        
                        CircleProgressView(progress: progress, targetCalo: $eatenCalo)
                            .frame(width: 200)
                    }
                    .frame(maxWidth: .infinity)
                    // MARK: Displaying all information and calculation about carbs, protein and fat
                    HStack(){
                        TargetView(name: "Carbs", current: currentCarbs, max: targetCalo*0.1)
                        TargetView(name: "Protein", current: currentProtein, max: targetCalo*0.075)
                        TargetView(name: "Fat", current: currentFat, max: targetCalo*0.03)
                    }
                    .padding(.vertical, 20)
                    .background(Color("Dark grey"))
                    .cornerRadius(15)
                    // MARK: Show the current day
                    HStack(){
                        Image(systemName: "calendar")
                        Text("TODAY ")
                        Text("\(date.formatted(.dateTime.day().month().year()))").textCase(.uppercase)
                    }
                    // MARK: Cards that navigates to add/remove food items
                    TargetCardView(type: "Breakfast", imageName: "meal1", selectionList: $selectionList, showPicker: $showPicker)
                    TargetCardView(type: "Lunch", imageName: "meal2", selectionList: $selectionList, showPicker: $showPicker)
                    TargetCardView(type: "Dinner", imageName: "meal3", selectionList: $selectionList, showPicker: $showPicker)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .onTapGesture {
            if(self.showPicker){
                self.showPicker = false
            }
        }
        .onChange(of: selectionList){newValue in
            self.progress = calculateAllCalo(selectionList)/targetCalo*100
            self.currentCarbs = calculateAllCarbs(selectionList)
            self.currentProtein = calculateAllProtein(selectionList)
            self.currentFat = calculateAllFat(selectionList)
            self.eatenCalo = self.targetCalo-calculateAllCalo(selectionList)
        }
        .onAppear(){
            self.eatenCalo = self.targetCalo-calculateAllCalo(selectionList)
        } // end of ScrollView
    } //end of ZStack
    // MARK: All the necessary function to calculate nutrition
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


