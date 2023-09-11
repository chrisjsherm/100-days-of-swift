//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Christopher Sherman on 2023-09-11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Align the two views with midAccountAndName so their centers are
        // both on the midAccountAndName guide of HStack.
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("paul-hudson")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
