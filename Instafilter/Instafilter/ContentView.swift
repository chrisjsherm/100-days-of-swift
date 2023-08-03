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
    @State private var filterRadius = 100.0
    @State private var currentFilter: CIFilter = CIFilter.circularScreen()
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?
    
    let context = CIContext()

    var body: some View {
        NavigationStack {
            VStack {
                if image != nil {
                    image!
                        .resizable()
                        .scaledToFit()
                    
                    if (currentFilter.inputKeys.contains(kCIInputIntensityKey) ||
                        !currentFilter.inputKeys.contains(kCIInputRadiusKey)) {
                        Slider(value: $filterIntensity, in: 0.0...1.0)
                            .padding(.top)
                            .onChange(of: filterIntensity) { _ in
                                filterImage()
                            }
                        Text("Filter intensity: \(filterIntensity, specifier: "%.1f")")
                    }
                    
                    if (currentFilter.inputKeys.contains(kCIInputRadiusKey)) {
                        Slider(value: $filterRadius, in: 0.0...200.0)
                            .padding(.top)
                            .onChange(of: filterRadius) { _ in
                                filterImage()
                            }
                        Text("Radius: \(filterRadius, specifier: "%.1f")")
                    }
                    
                    Button("Change filter") {
                        showingFilterSheet = true
                    }
                    .padding(.top)
                    
                    Button("Save photo", action: save)
                        .padding(.top)
                    
                    Button("Select new photo") {
                        showingImagePicker = true
                    }
                    .padding(.top)
                } else {
                    Text("Tap to select a photo")
                    .frame(width: 200, height: 200)
                    .background(Rectangle()
                        .fill(.gray)
                    )
                    .foregroundColor(.white)
                    .onTapGesture {
                        showingImagePicker = true
                    }
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Circular Screen") { setFilter(CIFilter.circularScreen())}
                Button("Cancel", role: .cancel) { }
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
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputWidthKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputWidthKey)}

        guard let outputImage = currentFilter.outputImage else {return}

        if inputKeys.contains(kCIInputCenterKey) {
            let width = (inputImage?.size.width ?? 0.0) / 2.0
            let height = (inputImage?.size.height ?? 0.0) / 2.0
            print("Width: \(width)")
            print("Height: \(height)")
            let vect = CIVector(x: width, y: height)
            currentFilter.setValue(vect, forKey: kCIInputCenterKey)
        }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Saved image successfully")
        }
        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
