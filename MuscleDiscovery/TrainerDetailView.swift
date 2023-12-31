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

struct TrainerDetailView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
    // Bind presentation mode of DetailView to  the PokeListView and will be used by the custome back button to dismiss the view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var trainer: Trainer
    
    @State private var percent: CGFloat = 0
    
    @State private var rating: Double = 0.0
    
    @State var showingTabBar: Bool = false
    
    @State private var blinking: Bool = false
    @Binding var showing: Bool
    
    var backButton: some View {
        Button(action: {
            withAnimation() {
                self.showingTabBar = true
                self.presentationMode.wrappedValue.dismiss()
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
        // MARK: ZStack for background color
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            // MARK: Main ScrollView
            ScrollView {
                //MARK: Main VStack
                VStack (spacing: 30) {
                    // MARK: HStack for avt and basic info
                    HStack (spacing: 25) {
                        // MARK: Avatar image
                        Circle()
                            .fill(Color("Background"))
                            .frame(width: 125)
                            .overlay(alignment: .center, content: {
                                AsyncImage(url: URL(string: trainer.imageURL!)) {image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 120)
                                } placeholder: {
                                    ProgressView()
                                        .tint(Color("Neon"))
                                }
                            })
                            .padding(.leading, 20)

                        // MARK: Name, experience and decoration
                        VStack (spacing: 15) {
                            Text(trainer.name!)
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("\(trainer.experience!) year\( trainer.experience! > 1 ? "s" : "") experience")
                                .font(.headline)
                                .foregroundColor(Color("Text gray"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Professional Coach")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("Neon"))
                                .padding()
                                .background(
                                    Rectangle()
                                        .fill(Color("Background"))
                                        .cornerRadius(10)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .shadow(color: Color("BlackTransparent"), radius: blinking ? 3 : 7)
                                )
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onAppear {
                                    // Create animation to blink the button and make it repeate forever
                                    let animation = Animation.easeInOut(duration: 1).repeatForever(autoreverses:true)
                                    
                                    withAnimation(animation) {
                                        // Toggle to blink the button every 1s with animation
                                        blinking = true
                                    }
                                }
                        } // end VStack Name, experience and decoration
                        
                    } // end HStack for avt and basic info
                    
                    // MARK: VStack for introduction
                    VStack (spacing: 10) {
                        Text("Introduction")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                        
                        Text(trainer.introduction!)
                            .font(.body)
                            .foregroundColor(Color("Text gray"))
                            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(7)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    
                        
                    // MARK: VStack for highlight information
                    VStack (spacing: 10) {
                        Text("Highlights")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading)
                        
                        // MARK: Highlights
                        ScrollView(.horizontal) {
                            HStack (spacing: 20) {
                                ForEach(trainer.highlights!, id:\.self) {info in
                                    Text(info)
                                        .font(.headline)
                                        .foregroundColor(Color("Text gray"))
                                        .padding()
                                        .background(
                                            Rectangle()
                                            .fill( Color("Background"))
                                            .cornerRadius(25)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .modifier(Shadown3DModifier())
                                        )
                                    
                                } // end ForEach
                                
                                Spacer()
                            }
                            .padding(.leading)
                            .frame(height: 70)
                            
                        } // end ScrollView highlights
                        .frame(height: 70)
                        
                    } // end VStack for highlight
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    
                    // MARK: Rating
                    VStack (spacing: 10) {
                        Text("Rating")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading)
                        
                        // MARK: Rating
                        ZStack {
                            CircularProgress(percent: trainer.rating! / 5)
                            
                            Text("\(rating.clean) / 5.0")
                                .font(.title)
                                .fontWeight(.bold)
                                .gradientForeground(linearColor: LinearConstant.linearOrange)
                                .onAppear {
                                    self.runCounter(counter: self.$rating, start: 0.0, end: trainer.rating!, speed: 0.04)
                                }
                                
                            
                        } // end ZStack Circle Rating
                        
                    } // end VStack for rating
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                        
                    Spacer()
                }
            } // end Main ScrollView
            
            // MARK: Button to Navigate to booking view
            NavigationLink(destination: AppointmentBookingView(trainer: trainer, showing: self.$showing)) {
                Text("Book an Appointment")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .background(
                        Rectangle()
                        .fill(Color("Neon"))
                        .cornerRadius(25)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .shadow(color: .white.opacity(0.4), radius: 4)
                    )

            }
            .modifier(Shadown3DModifier())
            .frame(maxHeight: UIScreen.main.bounds.height, alignment: .bottom)
                
        } // end ZStack for background color
        // MARK: Hide default Back Button
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .toolbar(showingTabBar ? .visible : .hidden, for: .tabBar)
        .preferredColorScheme(isDarkMode ? .dark : .light)

    }
    
    // This function can be used to animate a counter or perform any task that requires incrementing a value over time.
    func runCounter(counter: Binding<Double>, start: Double, end: Double, speed: Double) {
        counter.wrappedValue = start

        Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { timer in
            counter.wrappedValue += 0.1
            counter.wrappedValue = Double(round(10 * counter.wrappedValue) / 10)
            
            if counter.wrappedValue == end {
                timer.invalidate()
            }
        }
    }
}
