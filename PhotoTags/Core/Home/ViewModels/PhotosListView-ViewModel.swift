//
//  ContentView-ViewModel.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 1/04/22.
//

import Foundation
import SwiftUI
import CoreLocation

extension PhotosListView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var photos: [Photo]
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPhotos")
        
        init() {
            do {
                let dataSaved = try Data(contentsOf: savePath)
                let photosSaved = try JSONDecoder().decode([Photo].self, from: dataSaved)
                photos = photosSaved.sorted()
                return
            } catch {
                print("[😀] Failed trying to get contents at path: \(savePath.description)")
            }
            photos = []
        }
        
        deinit {
            print("[😀] Photos list view model deinitialized")
        }
        
        func addNewPhoto(image: UIImage, name: String, location: CLLocationCoordinate2D) {
            let imageData = image.jpegData(compressionQuality: 0.8) ?? Data()
            let latitude = location.latitude
            let longitude = location.longitude
            
            let newPhoto = Photo(image: imageData, name: name, latitude: latitude, longitude: longitude)
            
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
            do {
                let data = try JSONEncoder().encode(photos)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("[😀] Unable to save data! error: \(error.localizedDescription)")
            }
        }
    }
}
