//
//  ContentView.swift
//  Bucket List
//
//  Created by Christopher Sherman on 2023-08-04.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isUnlocked {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())

                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.selectedPlace = location
                        }
                    }
                }
                .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                    }
                }
            } else {
                Button("Unlock Places") {
                    viewModel.authenticate()
                }
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) {
                viewModel.update(location: $0)
            }
        }
        .alert(isPresented: $viewModel.authenticationFailed) {
            Alert(
                title: Text("Authentication failed"),
                message: Text(
                    "Ensure you have given the app permission to use FaceID or TouchID in Settings."),
                dismissButton: .default(Text("OK"))
            )
            
        }
        .onAppear(perform: viewModel.authenticate)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
