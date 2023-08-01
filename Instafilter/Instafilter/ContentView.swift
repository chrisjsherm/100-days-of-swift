//
//  ContentView.swift
//  Instafilter
//
//  Created by Christopher Sherman on 2023-07-27.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var filterIntensity = 0.5

    var body: some View {
        NavigationStack {
            VStack {
                if image != nil {
                    image!
                        .resizable()
                        .scaledToFit()
                    
                    Slider(value: $filterIntensity, in: 0.0...1.0)
                        .padding(.top)
                    Text("Filter intensity: \(filterIntensity, specifier: "%.1f")")
                    
                    Button("Save photo") {
                        guard let inputImage = inputImage else { return }
                        
                        let imageSaver = ImageSaver()
                        imageSaver.writeToPhotoAlbum(image: inputImage)
                    }
                    .padding(.top)
                } else {
                    Button("Tap to select a photo") {
                       showingImagePicker = true
                    }
                    .frame(width: 200, height: 300)
                    .background(Rectangle()
                        .fill(.gray)
                    )
                    .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) {
                _ in loadImage()
            }
            .navigationTitle("Instafilter")
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
