//
//  ContentView-ViewModel.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 1/04/22.
//

import Foundation
import SwiftUI

extension PhotosListView {
    @MainActor class ViewModel: ObservableObject {
        @Published var photos: [Photo]
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPhotos")
        
        init() {
            var photosSaved = [Photo]()
            do {
                let dataSaved = try Data(contentsOf: savePath)
                let photosDataSaved = try JSONDecoder().decode([PhotoData].self, from: dataSaved)
                
                photosDataSaved.forEach { photoData in
                    let photo = Photo(id: photoData.id, image: UIImage(data: photoData.image) ?? UIImage(), name: photoData.name)
                    
                    photosSaved.append(photo)
                }
            } catch {
                print("[😀] Failed trying to get contents at path: \(savePath.description)")
            }
            photos = photosSaved.sorted()
        }
        
        func addNewPhoto(image: UIImage, name: String) {
            let newPhoto = Photo(image: image, name: name)
            var allPhotos = photos
            allPhotos.append(newPhoto)
            
            withAnimation {
                photos = allPhotos.sorted()
            }
            save()
        }
        
        func delete(at offsets: IndexSet) {
            photos.remove(atOffsets: offsets)
            save()
        }
        
        func save() {
            var photosData = [PhotoData]()
            
            photos.forEach { photo in
                if let jpegData = photo.image.jpegData(compressionQuality: 0.8) {
                    
                    let newPhotoData = PhotoData(id: photo.id, image: jpegData, name: photo.name)
                    
                    photosData.append(newPhotoData)
                }
            }
            do {
                let data = try JSONEncoder().encode(photosData)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("[😀] Unable to save data! error: \(error.localizedDescription)")
            }
        }
    }
}
