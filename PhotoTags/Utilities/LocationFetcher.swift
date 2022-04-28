//
//  LocationFetcher.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 3/04/22.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    var location: ((CLLocation) -> Void)?
        
    var authorizationChanged: ((Bool) -> Void)?
        
    override init() {
        super.init()
        self.manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastKnownLocation = locations.first {
            location?(lastKnownLocation)
            manager.stopUpdatingLocation()
            print("user location: \(lastKnownLocation)")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            authorizationChanged?(true)
        } else {
            authorizationChanged?(false)
        }
    }
    
    func isAuthorized() -> Bool {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            return true
        } else {
            return false
        }
    }
}
