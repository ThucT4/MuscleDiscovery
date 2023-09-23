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

struct MainMenuView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
    init() {
        setTabbarColor()
    }
    
    var body: some View {
        TabView {
            AppointmentListView(userID: viewModel.currentUser?.id ?? "")
                .tabItem{
                    Image(systemName: "figure.strengthtraining.traditional")
                        .font(.headline)
                        .padding(.vertical)
                }
            
            FoodAnalysisView()
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                        .font(.headline)
                        .padding(.vertical)
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                        .font(.headline)
                        .padding(.vertical)
                }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            setTabbarColor()
        }
        .onChange(of: isDarkMode) { newValue in
            setTabbarColor()
            print(isDarkMode)
        }
    
    }
    
    func setTabbarColor() {
        let image = UIImage.gradientImageWithBounds(
            bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: 8),
            colors: [
                UIColor.clear.cgColor,
                UIColor.black.withAlphaComponent(0.1).cgColor
            ]
        )
        
        // Color Customize for tabbar
        let standardAppearance = UITabBarAppearance()
//        standardAppearance.backgroundColor = UIColor(isDarkMode ? .white : Color(red: 28, green: 28, blue: 30))
        
        standardAppearance.configureWithTransparentBackground()
        standardAppearance.backgroundColor = UIColor.systemGray6
        standardAppearance.backgroundImage = UIImage()
        standardAppearance.shadowImage = image
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor(Color("Gray"))
        itemAppearance.selected.iconColor = UIColor(Color("Neon"))
        standardAppearance.inlineLayoutAppearance = itemAppearance
        standardAppearance.stackedLayoutAppearance = itemAppearance
        standardAppearance.compactInlineLayoutAppearance = itemAppearance
        UITabBar.appearance().standardAppearance = standardAppearance
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
