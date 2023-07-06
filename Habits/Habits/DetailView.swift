//
//  DetailView.swift
//  Habits
//
//  Created by Christopher Sherman on 2023-07-04.
//

import SwiftUI

struct DetailView: View {
    @StateObject var activity: Activity

    var body: some View {
        NavigationStack {
            VStack {                
                Stepper("\(activity.hoursCompleted) hours completed",
                        value: $activity.hoursCompleted, in: 0...24)
            }
            .navigationTitle("\(activity.name)")
        }
        .padding()
        
        Spacer()
    }
}
