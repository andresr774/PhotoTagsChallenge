//
//  PhotoDetailView.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 2/04/22.
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo
    
    var body: some View {
        Image(uiImage: photo.image)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle(photo.name)
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhotoDetailView(photo: Photo.example)
        }
    }
}
