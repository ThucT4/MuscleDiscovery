import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    var imageUrl: String = "https://firebasestorage.googleapis.com/v0/b/muscledicovery.appspot.com/o/avatars%2Favatar-default-icon.png?alt=media&token=7571f663-6784-4e27-a9c1-8eec9e3c6742"
    
    var initials: String {
        let formmater = PersonNameComponentsFormatter()
        if let components = formmater.personNameComponents(from: fullname) {
            formmater.style = .abbreviated
            return formmater.string(from: components)
        }
        
        return ""
    }
}
