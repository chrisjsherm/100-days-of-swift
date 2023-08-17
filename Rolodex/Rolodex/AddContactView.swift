//
//  AddContactView.swift
//  Rolodex
//
//  Created by Christopher Sherman on 2023-08-17.
//

import SwiftUI

struct AddContactView: View {
    @State private var showImagePicker = false
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationStack {
            VStack {
                if image != nil {
                    image!
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Tap to select a profile photo")
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity
                        )
                        .background(Rectangle()
                            .fill(.white)
                        )
                        .foregroundColor(
                            .primary
                        )
                        .onTapGesture {
                            showImagePicker = true
                        }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in
                loadImage()
            }
            .navigationTitle("Add Contact")
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
