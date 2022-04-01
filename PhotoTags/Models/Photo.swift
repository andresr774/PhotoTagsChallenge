//
//  Photo.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 1/04/22.
//

import Foundation
import SwiftUI

struct Photo: Identifiable, Comparable {
    let id: UUID
    let image: UIImage
    let name: String
    
    static func <(lhs: Photo, rhs: Photo) -> Bool {
        lhs.name < rhs.name
    }
    
    static let example = Photo(id: UUID(), image: UIImage(systemName: "person") ?? UIImage(), name: "Person 1")
}
