//
//  DetailView.swift
//  Habits
//
//  Created by Christopher Sherman on 2023-07-04.
//

import SwiftUI

struct DetailView: View {
    var sport: Sport
    @State private var hoursCompleted = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(sport.rawValue)")
                .font(.largeTitle)
            
            Stepper("\(hoursCompleted) hours complete", value: $hoursCompleted, in: 0...24)
        }
        .padding()
        
        Spacer()
    }
}
