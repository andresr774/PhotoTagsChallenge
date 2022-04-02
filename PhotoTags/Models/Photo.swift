//
//  Photo.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 1/04/22.
//

import SwiftUI

struct Photo: Identifiable, Comparable {
    var id = UUID()
    let image: UIImage
    let name: String
    
    static func <(lhs: Photo, rhs: Photo) -> Bool {
        lhs.name < rhs.name
    }
    
    static let example = Photo(id: UUID(), image: UIImage(systemName: "photo") ?? UIImage(), name: "Image 1")
}

struct PhotoData: Codable, Comparable {
    let id: UUID
    let image: Data
    let name: String
    
    static func <(lhs: PhotoData, rhs: PhotoData) -> Bool {
        lhs.name < rhs.name
    }
}
