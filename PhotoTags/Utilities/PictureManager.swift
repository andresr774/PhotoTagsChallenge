//
//  PictureManager.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 5/04/22.
//

import Foundation
import SwiftUI

struct PictureManager: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: PictureManager
        
        init(_ parent: PictureManager) {
            self.parent = parent
            print("[😀] Picture Manager Coordinator initialized")
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            print("[😀] Picture Manager dismissed")
            guard let image = info[.editedImage] as? UIImage else {
                print("No image found")
                return
            }
            parent.image = image
        }
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = context.coordinator
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
