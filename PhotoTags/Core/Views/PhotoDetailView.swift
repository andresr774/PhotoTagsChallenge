//
//  PhotoDetailView.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 2/04/22.
//

import SwiftUI
import MapKit

struct PhotoDetailView: View {
    @StateObject private var vm: ViewModel
    let photo: Photo
    
    init(photo: Photo) {
        let center = CLLocationCoordinate2D(latitude: photo.latitude, longitude: photo.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        _vm = StateObject(wrappedValue: ViewModel(mapRegion: region))
        self.photo = photo
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Image(uiImage: UIImage(data: photo.image) ?? UIImage())
                .resizable()
                .scaledToFit()
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            Map(coordinateRegion: $vm.mapRegion, annotationItems: [photo]) {
                MapMarker(coordinate: $0.location, tint: .red)
            }
            .frame(minHeight: 100)
            .cornerRadius(30)
        }
        .padding()
        .navigationTitle(photo.name)
        //.navigationBarHidden(true)
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhotoDetailView(photo: Photo.example)
        }
    }
}
