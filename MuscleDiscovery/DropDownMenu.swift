//
//  DropDownMenu.swift
//  MuscleDiscovery
//
//  Created by Thuc on 19/9/2023.
//

import SwiftUI

struct DropDownMenu: View {
    @EnvironmentObject var trainerListViewModel: TrainerViewModel
    
    @State var selectedOption: String = "Rating 0-9"
    
    // All sorting type will be displayed as option for user
    var sortType: [String] = ["Rating 0-9", "Rating 9-0", "Experience 0-9", "Experience 9-0"]
    
    var body: some View {
        Menu {
            // Iterate through all type to display all options
            ForEach(sortType, id: \.self) { option in
                // Each option is displayed as button
                Button(action: {// When the button is clicked
                    // Change the filterType value to let the filteredList filter pokemons
                    if (option.contains("Rating")) {
                        trainerListViewModel.sortByRating(desc: option.contains("0-9") ? false : true)
                    }
                    else {
                        trainerListViewModel.sortByExperience(desc: option.contains("0-9") ? false : true)
                    }
                    
                    // Change the selectedOption to let the dropdownMenu update the background color
                    selectedOption = option
                }
                ) {
                    // Display type as label of button
                    Text(option)
                }
            }
        }label: { // The label of Menu
            // Display horizontally
            HStack {
                // Display current selected option
                Text(selectedOption)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                // An decoration arrow
                Text("⌵")
                    .offset(y: -4)
                    .padding(.trailing, 15)
            }
            // Change text color based on the selected type (element)
            .foregroundColor(ColorConstant.black)
            .font(.headline)
            .frame(width: 150, height: 42)
            // Change background color based on the selected type (element)
            .background(Color("Neon"))
            // Rounded the corners
            .cornerRadius(49)
        }
        .padding(.horizontal)
    }
}

struct DropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropDownMenu()
    }
}
