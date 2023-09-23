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
import StreamVideo
import StreamVideoSwiftUI

struct VideoCallView: View {
    // Bind presentation mode of DetailView to  the PokeListView and will be used by the custome back button to dismiss the view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var videoCallViewModel: CallViewModel = .init()
    
    private var client: StreamVideo
    
    private let apiKey: String = "mmhfdzb5evj2" // The API key can be found in the Credentials section
    private let token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiRGFydGhfS3JheXQiLCJpc3MiOiJwcm9udG8iLCJzdWIiOiJ1c2VyL0RhcnRoX0tyYXl0IiwiaWF0IjoxNjk0ODUwMzk2LCJleHAiOjE2OTU0NTUyMDF9.HCSA3UMcJFaTkTx4fUIV8QcJLRAWg0P1L7yCi6rvFG8" // The Token can be found in the Credentials section
    private let callID: String
    
    @State var ringing: Bool = false
    
    init(appointment: Appointment) {
        // Initialize Stream Video client
        self.client = StreamVideo(
            apiKey: apiKey,
            user: .init(id: "Thuc", name: "Customer Name", imageURL: .init(string: "https://firebasestorage.googleapis.com/v0/b/muscledicovery.appspot.com/o/food1.jpeg?alt=media&token=2cb8b8f5-9205-4601-b2cc-d97a2cb670ee")),
            token: .init(stringLiteral: token)
        )
        
        self.callID = appointment.documentID!
        
        print(callID)
    }
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea(.all)
            
            VStack {
                if videoCallViewModel.call != nil {
                    CallContainer(viewFactory: DefaultViewFactory.shared, viewModel: videoCallViewModel)
                }
                else {
                    Image(systemName: "phone.circle.fill")
                        .font(.system(size: 100, weight: .bold))
                        .foregroundColor(Color("Neon"))
                        .rotationEffect(.degrees(ringing ? -20 : 20))
                        .onAppear {
                            // Create animation to blink the button and make it repeate forever
                            let animation = Animation.easeInOut(duration: 0.1).repeatForever(autoreverses:true)
                            
                            withAnimation(animation) {
                                // Toggle to blink the button every 1s with animation
                                ringing = true
                            }
                        }
                }
            }
        }
        .onChange(of: videoCallViewModel.callingState) { [prevState = videoCallViewModel.callingState] newValue in
            // If the call just end
            if (prevState == .inCall && newValue == .idle) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .onAppear {
            Task {
                guard videoCallViewModel.call == nil else { return }
                videoCallViewModel.startCall(callType: .default, callId: callID, members: [])
            }
        }
        // MARK: Hide default Back Button
        .navigationBarBackButtonHidden(true)
    }
}
