//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Christopher Sherman on 2023-08-28.
//

import SwiftUI
import CodeScanner

struct ProspectsView: View {
    @State private var isShowingScanner = false
    @EnvironmentObject var prospects: Prospects
    let filter: FilterType
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
            
        case .contacted:
            return prospects.people.filter {
                $0.isContacted
            }
            
        case .uncontacted:
            return prospects.people.filter {
                !$0.isContacted
            }
        }
    }
    
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
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
                .navigationTitle(title)
                .toolbar {
                    Button {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr],
                        simulatedData: "Paul Hudson\npaul@hackingwithswift.com",
                        completion: onScan)
                }
        }
    }
    
    func onScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]

            prospects.people.append(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
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
