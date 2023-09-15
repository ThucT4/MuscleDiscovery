import Foundation


/// Structure of individual page used for tab view in the How to play view
struct Page : Identifiable, Equatable {
    let id = UUID()
    var description: [String]
    var imgUrl: String
    var tag: Int
    
    // Static content of each page
    static var pages: [Page] = [
        Page(
             description: ["MEET YOUR COACH,", "START YOUR JOURNEY"],
             imgUrl: "Onboarding 1",
             tag: 0),
        
        Page(
             description: ["CREATE A WORKOUT PLAN", "TO STAY FIT"],
             imgUrl: "Onboarding 2",
             tag: 1),
        
        Page(
             description: ["ACTION IS THE", "KEY TO ALL SUCCESS"],
             imgUrl: "Onboarding 3",
             tag: 2),
    ]
}
