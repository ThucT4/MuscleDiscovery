import Foundation
import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift
import LocalAuthentication

protocol AuthenticationFormProtocol {
    var formIsActive: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    private var userListener: ListenerRegistration?
            
    @Published var isLoggedIn = false
    @Published var isSignupSuccess = false
    @Published var isBusy = false

    
    /// The app will retrieve user data in firestore by id
    /// and store them in current user every time the app run
    init() {
        Task {
            await fetchUser()
            
            // Start listening for user document changes
            startUserListener()
        }
    }
    
    func authenticate() async -> Int {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."
            
            var result: Int = 0
            
            await withUnsafeContinuation { continuation in
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                                // authentication has now completed
                                if success {
                                    result = 1
                                } else {
                                    result = 0
                                }
                                continuation.resume(returning: ())
                            }

            }
            
            return result
        } else {
            return -1
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
            self.isLoggedIn = true
            await fetchUser()
            
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(password, forKey: "password")
            
            print("Login success!")

        } catch {
            print("Failed to login! \(error.localizedDescription )")
        }
    }
     
    
    /// Create new user info and store them in Firestore
    /// - Parameters:
    ///   - email: Registerd email
    ///   - password: Email password
    ///   - fullname: Registered user's name
    func createUser(email: String, password: String, fullname: String) async throws {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
//                self.authenticationState = .FAILED
                print(error?.localizedDescription ?? "")
                
            } else {
                // Store authentication result
                do {
                    self.userSession = authResult?.user
                    
                    // Init User object with newly created user and store the encoded object to firestore
                    let user = User(id: authResult!.user.uid , fullname: fullname, email: email, imageUrl: "https://firebasestorage.googleapis.com/v0/b/muscledicovery.appspot.com/o/avatars%2Favatar-default-icon.png?alt=media&token=7571f663-6784-4e27-a9c1-8eec9e3c6742")
                    let encodedUser = try Firestore.Encoder().encode(user)
                    Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
                } catch {
                    print("Failed to create user! \(error.localizedDescription )")
                }
                self.isSignupSuccess = true
                print("Create user \(self.userSession?.description ?? "") success.")
            }
        }
    }
    
    
    /// Sign out current session
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            self.userSession = nil
            
            self.isLoggedIn = false
            self.isSignupSuccess = false
        } catch {
            print("Failed to logout user! \(error.localizedDescription )")
        }
    }
    
    
    /// Get registerd user info from Firebase by their id
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument()
        else {
            return
        }
        
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    /// Get registerd user info from Firebase by their id
    func fetchUserBy(id userID: String) async {
        guard let snapshot = try? await Firestore.firestore().collection("users").document(userID).getDocument()
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
                "fullname": fullname != "" ? fullname : currentUser?.fullname as Any,
                "email": email != "" ? email : currentUser?.email as Any
                // Add other fields you want to update here
            ]
            
            try await Firestore.firestore().collection("users").document(uid).updateData(userData)
            
            return true
            
        } catch {
            print("Failed to update user information: \(error.localizedDescription)")
            return false
        }
    }
    
    func updateUserAvatar(image: String) async throws -> Bool {
        do {
            guard let uid = Auth.auth().currentUser?.uid else {
                return false
            }
            
            // Update user information in Firestore
            let userData: [String: Any] = [
                "imageUrl": image
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
