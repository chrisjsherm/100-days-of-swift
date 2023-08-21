//
//  AddContactView.swift
//  Rolodex
//
//  Created by Christopher Sherman on 2023-08-17.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var showImagePicker = false
    @State private var name = ""
    @State private var showInvalidFormMessage = false
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationStack {
            VStack {
                if image != nil {
                    image!
                        .resizable()
                        .scaledToFit()
                    
                    Form {
                        TextField("Name", text: $name)
                    }
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
            .toolbar {
                Button("Save") {
                   onSave()
                }
            }
            .alert(isPresented: $showInvalidFormMessage) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please select a photo and enter a name for this contact."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
    }
    
    func onSave() {
        guard let validatedName = validateName(name: name) else {
            showInvalidFormMessage = true
            return
        }
        
        let newContact = Person(context: self.context)
        newContact.name = validatedName;
        
        guard let contactImage = inputImage else {
            showInvalidFormMessage = true
            return
        }
    
        let uuid = UUID()
        let fileName = "\(uuid.uuidString).jpg"
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            if let data = contactImage.jpegData(compressionQuality:  1),
                !FileManager.default.fileExists(atPath: fileURL.path) {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
            }
        } catch {
            print("Error: ", error.localizedDescription)
        }
        
        newContact.photoId = uuid;
        
        try? context.save()
        dismiss()
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func validateName(name: String) -> String? {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.count > 0 {
            return trimmedName
        }
        
        return nil
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
