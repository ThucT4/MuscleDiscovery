//
//  PhotoPickerView.swift
//  VideoCall
//
//  Created by Thuc on 21/9/2023.
//

import SwiftUI
import FirebaseStorage
import UIKit

struct PhotoPickerView: View {
    @State var isShowPicker: Bool = false
    @State var image: UIImage? = UIImage()
    @State var url: String? = ""
    @State var progress: Int = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 320)
                    Button(action: {
                        withAnimation {
                            self.isShowPicker.toggle()
                        }
                    }) {
                        Image(systemName: "photo")
                            .font(.headline)
                        Text("IMPORT").font(.headline)
                    }.foregroundColor(.black)
                    Spacer()
                    
                    
                    
                    AsyncImage(url: URL(string: url!)) {image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 120)
                    } placeholder: {
                        
                    }
                    
                    Text("\(self.progress)")
                }
            }
            .sheet(isPresented: $isShowPicker) {
                ImagePicker(image: self.$image)
            }
            .navigationBarTitle("Pick Image")
            .onChange(of: self.image) {_ in
                self.uploadMedia {url in
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
    }
    
    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {

       let storageRef = Storage.storage().reference().child("avatar.png")
        
       if let uploadData = self.image!.jpegData(compressionQuality: 0.8) {
           let uploadTask = storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
               if error != nil {
                   print("Upload image error")
                   completion(nil)
               } else {
                
                   
                   storageRef.downloadURL(completion: { (url, error) in
                       
                       print(url?.absoluteString)
                       completion(url?.absoluteString)
                   })

                 //  completion((metadata?.downloadURL()?.absoluteString)!))
                   // your uploaded photo url.
               }
           }
           
           uploadTask.observe(.progress) {snapshot in
               print(snapshot.progress?.totalUnitCount)
               print(snapshot.progress?.completedUnitCount)
//               print(type(of: snapshot.progress))
           }
       }
   }
}

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    var presentationMode

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


struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
    }
}
