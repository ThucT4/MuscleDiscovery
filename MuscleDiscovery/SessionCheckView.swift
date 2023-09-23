/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Lai Nghiep Tri, Thieu Tran Tri Thuc, Truong Bach Minh, Vo Thanh Thong
  ID: s3799602, s3870730, s3891909, s3878071
  Created  date: 23/09/2023
  Last modified: 23/09/2023
  Acknowledgement: iOS Development course (lecture and tutorial material slides), Apple Documentation, Code With Chris, Hacking with Swift, Medium.
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
