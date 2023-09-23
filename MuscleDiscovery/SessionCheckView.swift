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


/// This view is used for switching between Main Menu View and Login view
/// based on login status.
struct SessionCheckView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isLoading = false
    
    var body: some View {
        // Navigate to Main menu page if login success
        if viewModel.isLoggedIn {
            MainMenuView()
        } else { // At default, starting at login view after entering the app or login failed
            LoginView()
        }
    }
}

struct SessionCheckView_Previews: PreviewProvider {
    static var previews: some View {
        SessionCheckView()
    }
}
