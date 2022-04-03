//
//  PhotoDetailView.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 2/04/22.
//

import SwiftUI
import MapKit

struct PhotoDetailView: View {
    let photo: Photo
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: photo.image) ?? UIImage())
                .resizable()
                .scaledToFit()
            
            //Map(coordinateRegion: <#T##Binding<MKCoordinateRegion>#>)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
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
