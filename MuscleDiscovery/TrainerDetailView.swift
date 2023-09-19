//
//  TrainerDetailView.swift
//  MuscleDiscovery
//
//  Created by Thuc on 12/9/2023.
//

import SwiftUI

struct TrainerDetailView: View {
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
                .fill(ColorConstant.gray)
                .frame(height: 30)
                .overlay(alignment: .center, content: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                    
                })
                .foregroundColor(.black)
                .shadow(color: .white.opacity(0.35), radius: 7)
        }
        .contentShape(Circle())
        .padding(.trailing, 20)
    }
    
    var body: some View {
        // MARK: ZStack for background color
        ZStack {
            ColorConstant.black
                .edgesIgnoringSafeArea(.all)
            
            // MARK: Main ScrollView
            ScrollView {
                //MARK: Main VStack
                VStack (spacing: 30) {
                    // MARK: HStack for avt and basic info
                    HStack (spacing: 25) {
                        // MARK: Avatar image
                        Circle()
                            .fill(.white)
                            .frame(width: 125)
                            .overlay(alignment: .center, content: {
                                AsyncImage(url: URL(string: trainer.imageURL!)) {image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 120)
                                } placeholder: {
                                    
                                }
                            })
                            .padding(.leading, 20)

                        
                        VStack (spacing: 15) {
                            Text(trainer.name!)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("\(trainer.experience!) year\( trainer.experience! > 1 ? "s" : "") experience")
                                .font(.headline)
                                .foregroundColor(ColorConstant.textGray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Professional Coach")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(ColorConstant.luminousGreen)
                                .padding()
                                .background(
                                    Rectangle()
                                        .fill(ColorConstant.black)
                                        .cornerRadius(10)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .shadow(color: .white.opacity(0.5), radius: blinking ? 3 : 7)
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
                        }
                        
                    } // end HStack for avt and basic info
                    
                    // MARK: VStack for introduction
                    VStack (spacing: 10) {
                        Text("Introduction")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                        
                        Text(trainer.introduction!)
                            .font(.body)
                            .foregroundColor(ColorConstant.textGray)
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
                            .foregroundColor(.white)
                            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading)
                        
                        // MARK: Highlights
                        ScrollView(.horizontal) {
                            HStack (spacing: 20) {
                                ForEach(trainer.highlights!, id:\.self) {info in
                                    Text(info)
                                        .font(.headline)
                                        .foregroundColor(Color(red: 0.48, green: 0.47, blue: 0.47))
                                        .padding()
                                        .background(
                                            Rectangle()
                                            .fill(ColorConstant.black)
                                            .cornerRadius(25)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .shadow(color: .white.opacity(0.4), radius: 4)
                                        )
                                    
                                } // end ForEach
                                
                                Spacer()
                            }
                            .padding(.leading)
                            .frame(height: 70)
                            
                        } // end ScrollView highlights
                        .frame(height: 70)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    
                    // MARK: Rating
                    VStack (spacing: 10) {
                        Text("Rating")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
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
                        .fill(ColorConstant.luminousGreen)
                        .cornerRadius(25)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .shadow(color: .white.opacity(0.4), radius: 4)
                    )

            }
            .frame(maxHeight: UIScreen.main.bounds.height, alignment: .bottom)
                
        } // end ZStack for background color
        // MARK: Hide default Back Button
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .toolbar(showingTabBar ? .visible : .hidden, for: .tabBar)
    }
    
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
