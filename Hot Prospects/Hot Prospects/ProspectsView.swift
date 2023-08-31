//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Christopher Sherman on 2023-08-28.
//

import SwiftUI
import CodeScanner
import UserNotifications

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
    
    @State private var showingSortMenu = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(prospect.name)
                                .font(.headline)
                            
                            if prospect.isContacted {
                                Spacer()
                                Image(systemName: "checkmark.circle.fill")
                            }
                        }
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggleIsContacted(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggleIsContacted(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
                .navigationTitle(title)
                .toolbar {
                    Button {
                        showingSortMenu = true
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                    
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
                .confirmationDialog("Sort", isPresented: $showingSortMenu) {
                    Button {
                        prospects.sortOrder = ProspectsSortOrder.NameAsc
                    } label: {
                       Text("Name Ascending")
                    }
                    
                    Button {
                        prospects.sortOrder = ProspectsSortOrder.NameDesc
                    } label: {
                        Text("Name Descending")
                    }
                }
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let nineAMTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let oneMinTrigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 1, repeats: false
            )

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: oneMinTrigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
                print("Request scheduled.")
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                        print("Request scheduled.")
                    } else {
                        print("D'oh! Notification Center access was not granted by the user.")
                    }
                }
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

            prospects.add(person)
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
