//
//  CustomActivityFormView.swift
//  Habits
//
//  Created by Christopher Sherman on 2023-07-05.
//

import SwiftUI

struct CustomActivityFormView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var customActivities: Array<Activity>
    
    @State private var customName = ""
    @State private var customDescription = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    LabeledContent {
                        TextField("Activity Name", text: $customName)
                    } label: {
                        Text("Name")
                    }
                    
                    LabeledContent {
                        TextField("Activity Description", text: $customDescription, axis: .vertical)
                            .lineLimit(1...10)
                    } label: {
                        Text("Description")
                    }
                }
                
                Section(header: Text("Finish")) {
                    Button("Save") {
                        let activity = Activity(name: customName, description: customDescription)
                        customActivities.append(activity)
                        dismiss()
                    }
                    
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Custom Activity")
        }
    }
}

struct CustomActivityFormView_Previews: PreviewProvider {
    static var previews: some View {
        CustomActivityFormView(customActivities: .constant([]))
    }
}
