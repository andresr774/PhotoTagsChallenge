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
                ForEach(vm.photos) { photo in
                    NavigationLink {
                        PhotoDetailView(photo: photo)
                    } label: {
                        PhotoRowView(photo: photo)
                    }
                    .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                }
                .onDelete(perform: vm.delete)
            }
            .listStyle(.plain)
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
                //ImagePicker(image: $imageSelected)
                PictureManager(image: $imageSelected)
            }
            .onChange(of: imageSelected) { _ in
                if let _ = imageSelected {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        showAddPhotoView = true
                    }
                }
            }
            .sheet(isPresented: $showAddPhotoView) {
                AddPhotoView(image: imageSelected!) { name, location in
                    if let imageSelected = imageSelected {
                        vm.addNewPhoto(image: imageSelected, name: name, location: location)
                    }
                }
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
