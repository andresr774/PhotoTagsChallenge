//
//  AddPhotoView.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 1/04/22.
//

import SwiftUI
import CoreLocation

struct AddPhotoView: View {
    @Environment(\.dismiss) private var dismiss
    let locationFetcher = LocationFetcher()
    
    let image: UIImage
    let onSave: (_ name: String, _ location: CLLocationCoordinate2D) -> Void
    
    @State private var currentLocation: CLLocation?
    
    @State private var name = ""
    @FocusState private var fieldIsFocused: Bool
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var placemark: CLPlacemark?
        
    init(image: UIImage, onSave: @escaping (String, CLLocationCoordinate2D) -> Void) {
        self.image = image
        self.onSave = onSave
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                
                Text("New Photo")
                    .font(.title.weight(.semibold))
                    .frame(maxWidth: .infinity)
                
                Button("Save") {
                    save()
                }
                .font(.headline)
            }
            
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                        
            Label(
                placemark == nil ? "Fetching Location…" : "\(placemark!.locality ?? ""), \(placemark!.country ?? "")",
                systemImage: "mappin.and.ellipse"
            )
            .font(.caption)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                locationFetcher.locationAuthorized = { authorized in
                    if authorized {
                        fieldIsFocused = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            if let location = locationFetcher.lastKnownLocation {
                                currentLocation = location
                                updatePlacemark(location: location)
                                locationFetcher.stopUpdatingLocation()
                                print("[😀] current location on appear: \(location)")
                            }
                        }
                    }
                }
                locationFetcher.start()
            }
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    fieldIsFocused = true
                }
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func save() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedName.isEmpty {
            if let currentLocation = currentLocation {
                onSave(trimmedName, currentLocation.coordinate)
                dismiss()
            } else {
                showLocationAlert()
            }
        } else {
            alertTitle = "Name is empty!"
            alertMessage = "You must provide a name for the picture in order to save it"
            showAlert = true
        }
    }
    
    private func showLocationAlert() {
        alertTitle = "We couldn't get your location"
        alertMessage = "Please check your settings location"
        showAlert = true
    }
    
    private func updatePlacemark(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, _ in
            if let placemark = placemarks?.first {
                self.placemark = placemark
            }
        }
    }
}

struct AddPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotoView(image: UIImage(systemName: "photo")!) { _, _ in
            
        }
    }
}
