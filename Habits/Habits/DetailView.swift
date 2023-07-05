//
//  DetailView.swift
//  Habits
//
//  Created by Christopher Sherman on 2023-07-04.
//

import SwiftUI

struct DetailView: View {
    var name: String
    @State private var hoursComplete = 0
    
    var body: some View {
        NavigationStack {
            VStack {                
                Stepper("\(hoursComplete) hours complete", value: $hoursComplete, in: 0...24)
            }.navigationTitle("\(name)")
        }
        .padding()
        
        Spacer()
    }
}
