//
//  AddPhotoView.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 1/04/22.
//

import SwiftUI

struct AddPhotoView: View {
    @Environment(\.dismiss) private var dismiss
    
    let image: UIImage
    
    @State private var name = ""
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                
                Spacer()
                
                Button("Done") {
                    dismiss()
                }
                .font(.headline)
            }
            
            Text("New Photo")
                .font(.largeTitle.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)
            
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .cornerRadius(15)
                .padding(.bottom, 10)
            
            TextField("Add name...", text: $name)
                .focused($fieldIsFocused)
                .font(.headline)
                .frame(height: 52)
                .padding(.leading)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(12)
            
            Spacer()
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                fieldIsFocused = true
            }
        }
    }
}

struct AddPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotoView(image: UIImage(systemName: "photo")!)
    }
}
