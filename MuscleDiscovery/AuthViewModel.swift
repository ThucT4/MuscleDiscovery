import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsActive: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    /// The app will retrieve user data in firestore by id
    /// and store them in current user every time the app run
    init() {
        Task {
            await fetchUser()
        }
    }
    
    /// Sign up with email and password
    /// - Parameters:
    ///   - email: Registered email
    ///   - password: Email password
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("Failed to create user! \(error.localizedDescription )")
        }
    }
     
    
    /// Create new user info and store them in Firestore
    /// - Parameters:
    ///   - email: Registerd email
    ///   - password: Email password
    ///   - fullname: Registered user's name
    func createUser(email: String, password: String, fullname: String) async throws {
        do {
            // Create Firebase u ser
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid , fullname: fullname, email: email)
            
            let encodedUser = try Firestore.Encoder().encode(user)
            
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            print("Create new user success.")

            // Fetch after creating new user session
            await fetchUser()
        } catch {
            print("Failed to create user! \(error.localizedDescription )")
        }
    }
    
    
    /// Sign out current session
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            self.userSession = nil
        } catch {
            print("Failed to logout user! \(error.localizedDescription )")
        }
    }
    
    
    /// Delete the user account
//    func deleteAccount() {
//        let db = Firestore.firestore()
//        let userID = Auth.auth().currentUser!.uid
//
//        db.collection("users").document(userID).delete() { error in
//            if error == nil {
//                print("DEBUG: Failed to delete user!")
//            } else {
//                print("DEBUG: Delete user success.")
//            }
//        }
//    }
    
    /// Get registerd user info from Firebase by their id
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument()
        else {
            return
        }
        
        self.currentUser = try? snapshot.data(as: User.self)
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
       return try? Firestore.Encoder().encode(self)
    }
}
