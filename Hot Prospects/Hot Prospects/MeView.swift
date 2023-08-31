//
//  MeView.swift
//  Hot Prospects
//
//  Created by Christopher Sherman on 2023-08-28.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    @State private var qrCode = UIImage()
    
    private let imageSaver = ImageSaver()
    private var qrValue: String {
        return "\(name)\n\(emailAddress)"
    }
    
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)

                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            let image = generateQRCode(from: qrValue)
                            
                            imageSaver.writeToPhotoAlbum(image: image)
                        } label: {
                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .navigationTitle("Share my info")
            .onAppear(perform: updateQRCode)
            .onChange(of: name) { _ in
                updateQRCode()
            }
            .onChange(of: emailAddress) { _ in
                updateQRCode()
            }
        }
    }

    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg).resized(toWidth: 512) ?? UIImage()
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    private func updateQRCode() {
        qrCode = generateQRCode(from: qrValue)
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
