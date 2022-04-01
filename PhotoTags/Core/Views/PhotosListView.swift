//
//  ContentView.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 1/04/22.
//

import SwiftUI

struct PhotosListView: View {
    @StateObject private var vm = ViewModel()
    
    @State private var showImagePicker = false
    @State private var showAddPhotoView = false
    
    @State private var imageSelected: UIImage?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.photos) {
                    PhotoRowView(photo: $0)
                }
            }
            .navigationTitle("PhotoTags")
            .toolbar {
                Button {
                    showImagePicker = true
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $imageSelected)
            }
            .onChange(of: imageSelected) { _ in
                if let _ = imageSelected {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        showAddPhotoView = true
                    }
                }
            }
            .sheet(isPresented: $showAddPhotoView) {
                AddPhotoView(image: imageSelected!)
                    .interactiveDismissDisabled(true)
            }
        }
    }
}

struct PhotosListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosListView()
    }
}
