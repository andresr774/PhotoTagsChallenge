//
//  PhotoDetailView-ViewModel.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 3/04/22.
//

import Foundation
import MapKit

extension PhotoDetailView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion: MKCoordinateRegion
        
        init(mapRegion: MKCoordinateRegion) {
            self.mapRegion = mapRegion
        }
    }
}
