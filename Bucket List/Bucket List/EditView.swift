//
//  EditView.swift
//  Bucket List
//
//  Created by Christopher Sherman on 2023-08-08.
//

import SwiftUI

struct EditView: View {
    @StateObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
        
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.location.name)
                    TextField("Description", text: $viewModel.location.description)
                }
                
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    
                    newLocation.id = UUID()
                    newLocation.name = viewModel.location.name
                    newLocation.description = viewModel.location.description
                    
                    viewModel.onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
}

