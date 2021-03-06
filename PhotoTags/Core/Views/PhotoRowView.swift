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
        HStack(spacing: 12) {
            Image(uiImage: UIImage(data: photo.image) ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(height: 55)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(maxWidth: UIScreen.main.bounds.width / 5)
            
            Text(photo.name)
                .font(.headline)
            
            Spacer()
        }
    }
}

struct PhotoRowView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoRowView(photo: Photo.example)
            .previewLayout(.sizeThatFits)
    }
}
