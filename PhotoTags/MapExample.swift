//
//  MapExample.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 27/04/22.
//

import MapKit
import SwiftUI

struct Location: Identifiable {
    let id: UUID
    var name: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct MapExample: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    @State private var locations = [Location]()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            // 44 by 44 is the minimum size recommended by apple.
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        
                        Text(location.name)
                            // This avoids any possible clipped to the text
                            .fixedSize()
                    }
                }
                // This is the map marker that apple gives us by default
                //MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), tint: .red)
            }
            .ignoresSafeArea()
            
            Circle()
                .fill(.blue.opacity(0.5))
                .frame(width: 32, height: 32)
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                let newLocation = Location(id: UUID(), name: "New location", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                locations.append(newLocation)
            } label: {
                Image(systemName: "plus")
                    .padding()
                    .background(.black.opacity(0.7))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
            }
            .padding(.trailing)
        }
    }
}

struct MapExample_Previews: PreviewProvider {
    static var previews: some View {
        MapExample()
    }
}
