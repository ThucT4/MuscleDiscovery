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
    private var userListener: ListenerRegistration?
    
    /// The app will retrieve user data in firestore by id
    /// and store them in current user every time the app run
    init() {
        Task {
            await fetchUser()
            
            // Start listening for user document changes
            startUserListener()
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
    
    /// Update current user infomation
    /// - Parameters:
    ///   - email: Registerd email
    ///   - fullname: Registered user's name
    func updateUser(fullname: String, email: String) async throws -> Bool {
        do {
            guard let uid = Auth.auth().currentUser?.uid else {
                return false
            }
            
            // Update user information in Firestore
            let userData: [String: Any] = [
                "fullname": fullname,
                "email": email
                // Add other fields you want to update here
            ]
            
            try await Firestore.firestore().collection("users").document(uid).updateData(userData)
            
            return true
            
        } catch {
            print("Failed to update user information: \(error.localizedDescription)")
            return false
        }
    }
    
    // Start listener
    private func startUserListener() {
           guard let uid = Auth.auth().currentUser?.uid else {
               return
           }
           
           let userDocRef = Firestore.firestore().collection("users").document(uid)
           
           userListener = userDocRef.addSnapshotListener { [weak self] documentSnapshot, error in
               if let error = error {
                   print("Error listening for user updates: \(error.localizedDescription)")
                   return
               }
               
               guard let document = documentSnapshot, document.exists else {
                   print("User document does not exist")
                   return
               }
               
               do {
                   if let user = try document.data(as: User?.self) {
                       self?.currentUser = user
                   } else {
                       print("Failed to decode user document")
                   }
               } catch {
                   print("Error decoding user document: \(error.localizedDescription)")
               }
           }
       }
       
       deinit {
           // Stop the user listener when the view model is deinitialized
           userListener?.remove()
       }
}

extension Encodable {
    var dictionary: [String: Any]? {
       return try? Firestore.Encoder().encode(self)
    }
}
