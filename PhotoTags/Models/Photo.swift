//
//  Photo.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 1/04/22.
//

import SwiftUI

struct Photo: Identifiable, Codable, Comparable {
    var id = UUID()
    let image: Data
    let name: String
    let latitude: Double
    let longitude: Double
    
    static func <(lhs: Photo, rhs: Photo) -> Bool {
        lhs.name < rhs.name
    }
        
    static let example = Photo(id: UUID(), image: dataImage, name: "Image 1", latitude: 26.305944, longitude: -80.182226)
    
    static var dataImage: Data {
        UIImage(systemName: "photo")?.jpegData(compressionQuality: 0.8) ?? Data()
    }
}
