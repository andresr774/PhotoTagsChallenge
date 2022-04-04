//
//  PhotoTagsApp.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 1/04/22.
//

import SwiftUI

@main
struct PhotoTagsApp: App {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.secondarySystemBackground
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            PhotosListView()
        }
    }
}
