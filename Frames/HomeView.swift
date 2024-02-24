//
//  HomeView.swift
//  Frames
//
//  Created by John Daniel Norombaba on 2/17/24.
//

import SwiftUI
import PhotosUI

struct PhotosSelector: View {
    @Binding var toDisplay: PhotosPickerItem?

    var body: some View {
        PhotosPicker(selection: $toDisplay,
                     matching: .images,
                     photoLibrary: .shared()) {
            Image(systemName: "photo.badge.plus.fill")
            Text("Select a photo")
        }
    }
}

struct HomeView: View {
    @State private var toDisplay: PhotosPickerItem?
    @State private var selectedImage: Image? // Store the loaded image

    var body: some View {
        VStack {
            Text("👋🏼 Welcome to Frames").font(.title)
            PhotosSelector(toDisplay: $toDisplay)

            // Display the selected image below the button
            if let selectedImage = selectedImage {
                selectedImage
                    .resizable()
                    .scaledToFit() // Adjust depending on desired layout
                    .frame(width: 350, height: 350) // Example size
                    .cornerRadius(20)
                    
            }
        }
        .onChange(of: toDisplay) { newValue in
            // Load image in the background to avoid UI freezing
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    selectedImage = Image(uiImage: image)
                }
            }
        }
    }
}



#Preview(windowStyle: .automatic) {
    HomeView()
}
