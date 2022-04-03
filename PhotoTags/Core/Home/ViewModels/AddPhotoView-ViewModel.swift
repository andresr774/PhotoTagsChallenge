//
//  AddPhotoView-ViewModel.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 3/04/22.
//

import Foundation

extension AddPhotoView {
    @MainActor class ViewModel: ObservableObject {
        let locationFetcher = LocationFetcher()
        //@Published var locationAuthorized: Bool
        
        init() {
            print("[😀] Add photo view model initialized")
//            if locationFetcher.manager.authorizationStatus == .authorizedWhenInUse || locationFetcher.manager.authorizationStatus == .authorizedAlways {
//                locationAuthorized = true
//            } else {
//                locationAuthorized = false
//            }
//            if !locationAuthorized {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    self.locationFetcher.start()
//                }
//            }
        }
        
        deinit {
            print("[😀] Add photo view model deinitialized")
        }
    }
}
