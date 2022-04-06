//
//  LocationFetcher.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 3/04/22.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocation?
    
    @Published var locationAuthorized: Bool
        
    override init() {
        print("[😀] Location Fetcher initialized")
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            locationAuthorized = true
        } else {
            locationAuthorized = false
        }
        super.init()
        
        self.manager.delegate = self
        
        if !locationAuthorized {
            start()
        }
    }
    
    deinit {
        print("[😀] Location Fetcher deinitialized")
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first
        print("user location: \(lastKnownLocation)")
    }
    
    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            Task{ @MainActor in
                locationAuthorized = true
            }
        }
    }
}
