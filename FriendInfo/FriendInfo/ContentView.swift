//
//  ContentView.swift
//  FriendInfo
//
//  Created by Christopher Sherman on 2023-07-21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var friends: FetchedResults<CachedFriend>
    private static let lastUpdatedKey = "lastUpdated"
    @State private var lastUpdatedVal = "—"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Last updated: \(lastUpdatedVal)")
                    .padding(.leading)
                
                List {
                    if friends.count > 0 {
                        ForEach(friends) { friend in
                            NavigationLink {
                                FriendDetailView(friend: friend)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(friend.wrappedName)
                                        .font(.headline)
                                        .padding(.bottom, 2)
                                    Text(friend.wrappedCompany).font(.subheadline)
                                    Text(friend.wrappedEmail).font(.subheadline)
                                }
                            }
                        }
                    } else {
                        Text("Empty")
                    }
                }
                .navigationTitle("Friends")
                .task {
                    await getData()
                }
            }
        }
    }
    
    func getLastUpdated() -> String {
        let timestamp = UserDefaults.standard.double(forKey: ContentView.lastUpdatedKey)
        if timestamp == 0.0 {
            return "—"
        }
        let date = Date(timeIntervalSince1970: timestamp)
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy HH:mm"
        return df.string(from: date)
    }
    
    func getData() async {
        print("Getting remote data")
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            print("Decoding response")
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedResponse = try decoder.decode([Friend].self, from: data)
            
            for response in decodedResponse {
                let friend = CachedFriend(context: moc)
                friend.name = response.name
                friend.id = response.id
                friend.age = response.age
                friend.company = response.company
                friend.email = response.email
                friend.address = response.address
                friend.about = response.about
                friend.registered = response.registered
                friend.tags = response.tags.joined(separator: ",")
            }
            
            await MainActor.run {
                try? moc.save()
            }
            print("Finished getting data")
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: ContentView.lastUpdatedKey)
            lastUpdatedVal = getLastUpdated()
        } catch {
            print("Invalid data")
            print(error)
            lastUpdatedVal = getLastUpdated()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
