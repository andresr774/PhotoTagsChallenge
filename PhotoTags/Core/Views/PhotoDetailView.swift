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
    
    @State private var mapRegion: MKCoordinateRegion
    @State private var mapHeight: CGFloat = 200
    
    @State private var viewJustOpen = true
    @State private var expandMap = false
    
    let expandImage = "arrow.up.backward.and.arrow.down.forward.circle.fill"
    let shrinkImage = "arrow.down.right.and.arrow.up.left.circle.fill"
    
    var body: some View {
        VStack(spacing: 20) {
            image
            
            // Read map height
            if viewJustOpen {
                GeometryReader { geo in
                    Rectangle().fill(.clear)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                mapHeight = geo.size.height
                                viewJustOpen = false
                            }
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay(alignment: .bottom) {
            map
        }
        .navigationTitle(photo.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init(photo: Photo) {
        self.photo = photo
        let center = CLLocationCoordinate2D(latitude: photo.latitude, longitude: photo.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        self._mapRegion = State(wrappedValue: region)
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhotoDetailView(photo: Photo.example)
        }
    }
}

extension PhotoDetailView {
    private var image: some View {
        Image(uiImage: UIImage(data: photo.image) ?? UIImage())
            .resizable()
            .scaledToFit()
            .fixedSize(horizontal: false, vertical: true)
            .padding()
    }
    private var map: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $mapRegion, annotationItems: [photo]) {
                MapMarker(coordinate: $0.location, tint: .red)
            }
            .cornerRadius(expandMap ? 0 : 15)
            expandButton
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: expandMap ? .infinity : mapHeight)
        .padding(expandMap ? 0 : 15)
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    private var expandButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.thickMaterial)
            
            Image(systemName: expandMap ? shrinkImage : expandImage)
                .font(.title2)
                .rotationEffect(Angle(degrees: 90))
                .foregroundColor(.primary.opacity(0.7))
        }
        .frame(width: 44, height: 44)
        .onTapGesture {
            withAnimation {
                expandMap.toggle()
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(10)
    }
}
