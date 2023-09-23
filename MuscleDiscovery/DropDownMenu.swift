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

struct DropDownMenu: View {
    @EnvironmentObject var trainerListViewModel: TrainerViewModel
    
    @State var selectedOption: String = "Rating 9-0"
    
    // All sorting type will be displayed as option for user
    var sortType: [String] = [ "Rating 9-0", "Rating 0-9", "Experience 9-0", "Experience 0-9"]
    
    var body: some View {
        Menu {
            // Iterate through all type to display all options
            ForEach(sortType, id: \.self) { option in
                // Each option is displayed as button
                Button(action: {// When the button is clicked
                    // Change the filterType value to let the filteredList filter pokemons
                    if (option.contains("Rating")) {
                        trainerListViewModel.sortByRating(desc: option.contains("0-9") ? true : false)
                    }
                    else {
                        trainerListViewModel.sortByExperience(desc: option.contains("0-9") ? true : false)
                    }
                    
                    // Change the selectedOption to let the dropdownMenu update the background color
                    selectedOption = option
                }
                ) {
                    HStack (spacing : 0) {
                        // Display type as label of button
                        if (option.contains("0-9")) {
                            Text("\(option.replacingOccurrences(of: "0-9", with: ""))")
                            
                            Image(systemName: "arrow.up.circle.fill")
                        }
                        else {
                            Text("\(option.replacingOccurrences(of: "9-0", with: ""))")
                            
                            Image(systemName: "arrow.down.circle.fill")
                        }
                        
                        Spacer()
                    }
                }
                .foregroundColor(.black)
            }
        }label: { // The label of Menu
            // Display horizontally
            HStack (spacing: 20) {
                // Display current selected option
                if (selectedOption.contains("0-9")) {
                    Text("\(selectedOption.replacingOccurrences(of: "0-9", with: "")) \(Image(systemName: "arrow.up.circle.fill"))")
                }
                else {
                    Text("\(selectedOption.replacingOccurrences(of: "9-0", with: "")) \(Image(systemName: "arrow.down.circle.fill"))")
                }
                
                // An decoration arrow
                Text("⌵")
                    .offset(y: -4)
            }
            .padding()
            .font(.headline)
            .foregroundColor(.black)
            .background(
                Rectangle()
                    .fill(Color("Neon"))
                    .frame(height: 42)
                    // Rounded the corners
                    .cornerRadius(49)
            )
        }
        .padding(.horizontal)
    }
}
