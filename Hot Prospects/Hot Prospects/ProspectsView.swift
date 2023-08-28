//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Christopher Sherman on 2023-08-28.
//

import SwiftUI

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
            
        case .contacted:
            return "Contacted people"
            
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var body: some View {
        NavigationView {
            Text("People: \(prospects.people.count)")
                .navigationTitle(title)
                .toolbar {
                    Button {
                        let prospect = Prospect()
                        prospect.name = "Paul Hudson"
                        prospect.emailAddress = "paul@hackingwithswift.com"
                        prospects.people.append(prospect)
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    @StateObject static var prospects = Prospects()
    
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(prospects)
    }
}

enum FilterType {
    case none, contacted, uncontacted
}
