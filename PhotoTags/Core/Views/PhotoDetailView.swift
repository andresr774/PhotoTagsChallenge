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
    @State private var imageHeight: CGFloat = 200
    @State private var expandMap = false
    
    @State private var scaleAmount = 1.0
    @State private var offset = CGSize.zero
    
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                scaleAmount = value
            }
            .onEnded { _ in
                withAnimation {
                    scaleAmount = 1.0
                }
            }
            //.simultaneously(with: drag)
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                print("Drag value: \(gesture)")
                if scaleAmount > 1.0 {
                    offset = gesture.translation
                }
            }
            .onEnded { _ in
                withAnimation {
                    offset = CGSize.zero
                }
            }
    }
    
    let expandLogo = "arrow.up.backward.and.arrow.down.forward.circle.fill"
    let shrinkLogo = "arrow.down.right.and.arrow.up.left.circle.fill"
    
    var body: some View {
        VStack(spacing: 30) {
            if !expandMap {
                image
                    .zIndex(1)
            }
            map
        }
        .padding(expandMap ? 0 : 15)
        .navigationTitle(photo.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if expandMap {
                toolbarImage
            }
        }
    }
    
    init(photo: Photo) {
        self.photo = photo
        let center = CLLocationCoordinate2D(latitude: photo.latitude, longitude: photo.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
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
            .scaleEffect(scaleAmount)
            .offset(offset)
            .gesture(magnification)
    }
    private var map: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $mapRegion, annotationItems: [photo]) {
                MapMarker(coordinate: $0.location, tint: .red)
            }
            .cornerRadius(expandMap ? 0 : 15)
            expandButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all, edges: expandMap ? .bottom : .horizontal)
    }
    
    private var expandButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.thickMaterial)
            
            Image(systemName: expandMap ? shrinkLogo : expandLogo)
                .font(.title2)
                .rotationEffect(Angle(degrees: 90))
                .foregroundColor(.primary.opacity(0.7))
        }
        .frame(width: 44, height: 44)
        .onTapGesture {
            withAnimation(.easeInOut) {
                expandMap.toggle()
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(10)
    }
    
    private var toolbarImage: some View {
        Image(uiImage: UIImage(data: photo.image) ?? UIImage())
            .resizable()
            .scaledToFit()
            .cornerRadius(6)
            .frame(width: 42, height: 36)
    }
}
