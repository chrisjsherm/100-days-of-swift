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
    @State private var currentFilter = CIFilter.sepiaTone()
    
    let context = CIContext()

    var body: some View {
        NavigationStack {
            VStack {
                if image != nil {
                    image!
                        .resizable()
                        .scaledToFit()
                    
                    Slider(value: $filterIntensity, in: 0.0...1.0)
                        .padding(.top)
                        .onChange(of: filterIntensity) { _ in
                            filterImage()
                        }
                    Text("Filter intensity: \(filterIntensity, specifier: "%.1f")")
                    
                    Button("Save photo", action: save)
                        .padding(.top)
                    
                    Button("Select new photo") {
                        showingImagePicker = true
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
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        filterImage()
    }
    
    func filterImage() {
        currentFilter.intensity = Float(filterIntensity)
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    
    func save() {
        guard let inputImage = inputImage else { return }
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
