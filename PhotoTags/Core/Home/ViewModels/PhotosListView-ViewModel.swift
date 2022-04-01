//
//  ContentView-ViewModel.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 1/04/22.
//

import Foundation

extension PhotosListView {
    @MainActor class ViewModel: ObservableObject {
        @Published var photos = [Photo]()
    }
}
