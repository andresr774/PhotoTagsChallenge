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
    let onSave: (String) -> Void
    
    @State private var name = ""
    @FocusState private var fieldIsFocused: Bool
    
    @State private var showNameAlert = false
    
    init(image: UIImage, onSave: @escaping (String) -> Void) {
        self.image = image
        self.onSave = onSave
    }
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                
                Text("New Photo")
                    .font(.title.weight(.semibold))
                    .frame(maxWidth: .infinity)
                
                Button("Save") {
                    let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !trimmedName.isEmpty {
                        onSave(name)
                        dismiss()
                    } else {
                        showNameAlert = true
                    }
                }
                .font(.headline)
            }
            
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            
            TextField("Name...", text: $name)
                .focused($fieldIsFocused)
                .font(.headline)
                .frame(height: 52)
                .padding(.leading)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(12)
            
            Spacer()
        }
        .padding([.top, .horizontal])
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                fieldIsFocused = true
            }
        }
        .alert("Name is empty!", isPresented: $showNameAlert) {
            Button("OK", role: .cancel) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    fieldIsFocused = true
                }
            }
        } message: {
            Text("You must provide a name for the picture in order to save it")
        }
    }
}

struct AddPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotoView(image: UIImage(systemName: "photo")!) { _ in
            
        }
    }
}
