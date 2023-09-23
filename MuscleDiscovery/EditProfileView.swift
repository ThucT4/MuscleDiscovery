import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct EditProfileView: View {
    @State private var isEditingName = false
    @State private var editedName = ""
    @State private var isEditingEmail = false
    @State private var editedEmail = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State var isPickerShowing = false
    
    @State var image: UIImage? = UIImage()
    @State var url: String? = ""
    @State var progress: Int = 0

    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Back Button
    var backButton: some View {
        Button(action: {
            withAnimation() {
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
        if let user = viewModel.currentUser {
            ZStack {
                // Background Color
                Color("Background")
                    .ignoresSafeArea(.all)
                
                VStack {
                    Spacer()
                    // Profile Image and Button
                    ZStack {
                        Circle()
                            .trim(from: 0.0, to: 0.75) // Trim 75% of the circle
                            .stroke(
                                LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing),
                                lineWidth: 3
                            )
                            .frame(width: 150, height: 150)
                            .rotationEffect(.degrees(-90)) // Rotate to start at the top
                        
                        AsyncImage(url: URL(string: viewModel.currentUser?.imageUrl ?? "https://firebasestorage.googleapis.com/v0/b/muscledicovery.appspot.com/o/avatars%2Favatar-default-icon.png?alt=media&token=7571f663-6784-4e27-a9c1-8eec9e3c6742")) {image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 150)
                        } placeholder: {
                            ProgressView()
                                .tint(Color("Neon"))
                        }
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button {
                                    isPickerShowing = true
                                } label: {
                                    ZStack {
                                        Circle()
                                            .fill(Color.gray) // Fill color of the circle
                                            .frame(width: 46, height: 46) // Size of the circle
                                        Image(systemName: "camera.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 23)
                                            .foregroundColor(Color.white)
                                    }
                                }
                            }
                            .sheet(isPresented: $isPickerShowing) {
                                ImagePicker(image: self.$image)
                            }
                            .onChange(of: self.image) {newValue in
                                self.uploadImage {url in
                                    if let url = url {
                                        // Use the URL returned by the completion handler
                                        print("Uploaded media URL: \(url)")
                                        self.url = url
                                    } else {
                                        // Handle the case when the URL is nil
                                        print("Error uploading media")
                                    }
                                }
                            }
                            
                        }
                        .frame(width: 130, height: 130)
                    }
                    .padding(.bottom, 50)
                    
                    Spacer()
                    
                    // MARK: Information
                    // Name
                    VStack(alignment: .leading) {
                        Divider()
                            .background(Color.gray)
                            .padding(.bottom, 10)
                        
                        Text("Name")
                            .font(.title3)
                            .bold()
                            .padding(.bottom, 5)
                            .padding(.horizontal)
                        
                        if isEditingName {
                            TextField("Enter name", text: $editedName, onCommit: {
                                // Save the edited name or perform any necessary actions
                                isEditingName = false
                            })
                            .font(.title3)
                            .foregroundColor(isDarkMode ? Color.white : Color.black)
                            .padding(.bottom, 15)
                            .padding(.horizontal)
                            .background(Color.clear) // Hide TextField background
                        } else {
                            Text(user.fullname)
                                .font(.title3)
                                .foregroundColor(isDarkMode ? Color.white : Color.black)
                                .padding(.bottom, 15)
                                .padding(.horizontal)
                                .onTapGesture {
                                    // Enable editing when tapped
                                    editedName = user.fullname
                                    isEditingName = true
                                }
                        }
                        
                        Divider()
                            .background(Color.gray)
                    }
                    .padding(.bottom, 10)
                    
                    // Email
                    VStack(alignment: .leading) {
                        Divider()
                            .background(Color.gray)
                            .padding(.bottom, 10)
                        
                        Text("Email")
                            .foregroundColor(isDarkMode ? ColorConstant.luminousGreen : ColorConstant.black)
                            .bold()
                            .font(.title3)
                            .padding(.bottom, 5)
                            .padding(.horizontal)
                        
                        if isEditingEmail {
                            TextField("Enter email", text: $editedEmail, onCommit: {
                                // Save the edited name or perform any necessary actions
                                isEditingEmail = false
                            })
                            .font(.title3)
                            .foregroundColor(isDarkMode ? Color.white : Color.black)
                            .padding(.bottom, 15)
                            .padding(.horizontal)
                            .background(Color.clear) // Hide TextField background
                        } else {
                            Text(user.email)
                                .font(.title3)
                                .foregroundColor(isDarkMode ? Color.white : Color.black)
                                .padding(.bottom, 15)
                                .padding(.horizontal)
                                .onTapGesture {
                                    // Enable editing when tapped
                                    editedEmail = user.email
                                    isEditingEmail = true
                                }
                        }
                        
                        Divider()
                            .background(Color.gray)
                    }
                    .padding(.bottom, 10)
                    
                    
                    
                    Spacer()
                    
                    // Save Button
                    Button {
                        isEditingName = false
                        isEditingEmail = false
                        
                        Task {
                            do {
                                let success = try await viewModel.updateUser(fullname: editedName, email: editedEmail)
                                
                                if success {
                                    // Update was successful, show the alert
                                    self.alertMessage = "Update user information successfully"
                                    self.showAlert.toggle()
                                    
                                    // Set a timer to automatically dismiss the alert after 3 seconds
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        self.showAlert = false
                                    }
                                } else {
                                    // Handle the case where the update was not successful
                                    print("User update failed.")
                                }
                            } catch {
                                // Handle error if the update fails
                                print("Failed to update user information: \(error.localizedDescription)")
                            }
                        }
                    } label: {
                        Text("Save")
                            .foregroundColor(Color.black)
                            .bold()
                            .frame(width: 260, height: 50)
                            .background(ColorConstant.luminousGreen)
                            .cornerRadius(50)
                            .padding(.bottom, 30)
                    }
                }
                .frame(width: 330)
            }
            // MARK: Hide default Back Button
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack (spacing: 20) {
                        backButton
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text(alertMessage)
                )
            }
        }
    }
        
    
    /// Upload image to Firebase Storage
    /// - Parameter completion: image url
    func uploadImage(completion: @escaping (_ url: String?) -> Void) {
        
        // Reference to firebase Storage
        let storageRef = Storage.storage().reference().child("avatars/avatar.jpeg")
        
        if let uploadData = self.image!.jpegData(compressionQuality: 0.5) {
            let uploadTask = storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil { // Upload error
                    print("error")
                    completion(nil)
                } else {
                    // Download image after upload
                    storageRef.downloadURL(completion: { (url, error) in
                        if let error = error {
                            print("DEBUG: DOWNLOAD FAILED")
                        }
                        
                        // Assign new avatar url
                        viewModel.currentUser!.imageUrl = url!.absoluteString
                        
                        // Update new user avatar
                        Task {
                            do {
                                let success = try await viewModel.updateUserAvatar(image: url!.absoluteString)
                                
                                if success {
                                    // Update was successful, show the alert
                                    self.alertMessage = "Update avatar success"
                                    self.showAlert.toggle()
                                    
                                    // Set a timer to automatically dismiss the alert after 3 seconds
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        self.showAlert = false
                                    }
                                } else {
                                    // Handle the case where the update was not successful
                                    print("Avatar update failed.")
                                }
                            } catch {
                                // Handle error if the update fails
                                print("Failed to update user avatar: \(error.localizedDescription)")
                            }
                        }
                        
                        print("Image URL: \(viewModel.currentUser!.imageUrl)")
                        completion(url?.absoluteString)
                    })
                }
            }
            
            // DEBUG: Monitor uploading process
            uploadTask.observe(.progress) {snapshot in
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                  / Double(snapshot.progress!.totalUnitCount)

                print(percentComplete)
            }
        }
    }
    
    
    /// Image picker used to select the image in Photo Library
    struct ImagePicker: UIViewControllerRepresentable {
        @Environment(\.presentationMode) var presentationMode
        @Binding var image: UIImage?
        
        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            @Binding var presentationMode: PresentationMode
            @Binding var image: UIImage?
            
            
            init(presentationMode: Binding<PresentationMode>, image: Binding<UIImage?>) {
                _presentationMode = presentationMode
                _image = image
            }
            
            func imagePickerController(_ picker: UIImagePickerController,
                                       didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                image = uiImage
                presentationMode.dismiss()
            }
            
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                
                presentationMode.dismiss()
                
            }
        }
        
        func makeCoordinator() -> Coordinator {
            return Coordinator(presentationMode: presentationMode, image: $image)
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController,
                                    context: UIViewControllerRepresentableContext<ImagePicker>) {
        }
    }
}
