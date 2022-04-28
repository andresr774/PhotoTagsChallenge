//
//  LocationFetcherExample.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 27/04/22.
//

import SwiftUI
import CoreLocation

struct LocationFetcherExample: View {
    let locationFetcher = LocationFetcher()
    @State private var locationAuthorized = false
    @State private var placemark: CLPlacemark?
    
    var body: some View {
        VStack(spacing: 20) {
            if locationAuthorized {
                Text("Current Location")
                    .font(.title.weight(.semibold))
                
                Label(
                    placemark == nil ? "Fetching Location…" : "\(placemark!.locality ?? ""), \(placemark!.country ?? "")",
                    systemImage: "mappin.and.ellipse"
                )
            } else {
                Text("😞 Location not authorized!")
                Button("Open Settings") {
                    openSettings()
                }
            }
        }
        .onAppear(perform: getCurrentLocation)
    }
    
    private func getCurrentLocation() {
        locationFetcher.location = {
            updatePlacemark(location: $0)
        }
        locationFetcher.authorizationChanged = { authorized in
            locationAuthorized = authorized
        }
        locationAuthorized = locationFetcher.isAuthorized()
        locationFetcher.start()
    }
    
    private func updatePlacemark(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, _ in
            if let placemark = placemarks?.first {
                self.placemark = placemark
            }
        }
    }
    
    private func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl) { success in
                print("Settings opened: \(success)")
            }
        }
    }
}

struct LocationFetcherExample_Previews: PreviewProvider {
    static var previews: some View {
        LocationFetcherExample()
    }
}
