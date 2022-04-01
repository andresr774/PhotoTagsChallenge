//
//  PhotoRowView.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 1/04/22.
//

import SwiftUI

struct PhotoRowView: View {
    let photo: Photo
    
    var body: some View {
        HStack {
            Image(uiImage: photo.image)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            
            Text(photo.name)
                .font(.headline)
            
            Spacer()
        }
    }
}

struct PhotoRowView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoRowView(photo: Photo.example)
    }
}
