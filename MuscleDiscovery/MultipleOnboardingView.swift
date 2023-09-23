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

/// Structure of aggregating onboarding view under tab view
struct MultipleOnboardingView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var pageIdx = 0  // Index of each instruction page
    private let pages: [Page] = Page.pages // list of instruction pages
    private let pageDots = UIPageControl.appearance() // Dot representation for corresponding page index
    
    // Dot corresponding to page position
    private var pageDotColor: UIColor {
        if (colorScheme == .dark) {
            return .green
        } else {
            return UIColor(Color("Neon"))
        }
    }
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea(.all)
            
            NavigationView {
                TabView(selection: $pageIdx) {
                    ForEach(pages) { page in
                        VStack {
                            // Introducing page
                            SingleOnboardingView(page: page)
                            
                            // Last page detected
                            if page == pages.last {
                                // Go to session check view
                                NavigationLink {
                                    SessionCheckView()
                                } label: {
                                    HStack(spacing: 20) {
                                        Text("Start now")
                                            .fontWeight(.regular)
                                            .font(.system(size: 20))
                                        Image(systemName: "arrowtriangle.forward.fill")
                                    }
                                    .foregroundColor(.black)
                                    .frame(width: UIScreen.main.bounds.width - 180, height: 60)
                                }
                                .background(Color("Neon"))
                                .cornerRadius(48)
                                .padding(.bottom, 12)
                            } else { // Move to next introducing pages
                                Button {
                                    pageIdx += 1
                                } label: {
                                    Image(systemName: "arrow.right.circle")
                                }
                                .tint(Color("Neon"))
                                .font(.system(size: 20))
                            }
                            
                            Spacer(minLength: 200)
                        } // VStack
                        .tag(page.tag)
                    } // ForEach
                } // TabView
                .edgesIgnoringSafeArea(.all)
                .animation(.easeOut, value: pageIdx)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .onAppear {
                    pageDots.currentPageIndicatorTintColor = UIColor(Color("Neon"))
                    pageDots.pageIndicatorTintColor = UIColor(named: "light-gray")
                } // TabView
                
            } // NaviationView
            
        } // ZStack
    }
}

struct MultipleOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleOnboardingView()
    }
}
