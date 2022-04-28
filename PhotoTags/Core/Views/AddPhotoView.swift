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
    @State private var locationAuthorized = false
    
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
                !locationAuthorized ? "Location not authorized" : placemark == nil ? "Fetching Location…" : "\(placemark!.locality ?? ""), \(placemark!.country ?? "")",
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
                .padding(.bottom)
            
            if !locationAuthorized {
                Text("Location Service not authorized!")
                Button("Open Settings", action: openSettings)
            }
            
            Spacer()
        }
        .padding([.top, .horizontal])
        .onAppear(perform: getCurrentLocation)
        .alert(alertTitle, isPresented: $showAlert) {
            if locationAuthorized {
                Button("OK", role: .cancel) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        fieldIsFocused = true
                    }
                }
            } else {
                Button("Open Settings") {
                    openSettings()
                }
                Button("Cancel", role: .cancel) { }
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func getCurrentLocation() {
        locationFetcher.location = { location in
            currentLocation = location
            updatePlacemark(location: location)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                fieldIsFocused = true
            }
        }
        locationFetcher.authorizationChanged = { authorized in
            locationAuthorized = authorized
        }
        locationAuthorized = locationFetcher.isAuthorized()
        locationFetcher.start()
    }
    
    private func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl) { success in
                print("Settings opened: \(success)")
                dismiss()
            }
        }
    }
    
    private func save() {
        guard locationAuthorized else {
            alertTitle = "Location Not Authorized!"
            alertMessage = "You need to authorize location service in order to save your picture"
            showAlert = true
            return
        }
        guard let currentLocation = currentLocation else {
            showLocationAlert()
            return
        }

        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedName.isEmpty {
            onSave(trimmedName, currentLocation.coordinate)
            dismiss()
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
