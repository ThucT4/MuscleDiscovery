import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
        
    var initials: String {
        let formmater = PersonNameComponentsFormatter()
        if let components = formmater.personNameComponents(from: fullname) {
            formmater.style = .abbreviated
            return formmater.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Iris Young", email: "iris.young@hotmail.com")
}
