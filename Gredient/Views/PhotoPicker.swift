//
//  PhotoPicker.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-04-22.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable{
    @Environment(\.managedObjectContext) var viewContext
    var member: FetchedResults<FMember>.Element
    @Binding var avatarImage: UIImage
    
    func makeUIViewController(context: Context) -> UIImagePickerController{
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker){
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                guard let data = image.jpegData(compressionQuality: 0.1), let compressedImage = UIImage(data: data) else{
                    // Show error or alert
                    return
                }
                photoPicker.avatarImage = compressedImage
            } else{
                // Return an error or show an alert
            }
            picker.dismiss(animated: true)
        }
    }
}


