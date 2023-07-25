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
    
    var body: some View {
        NavigationView {
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
                    if friends.isEmpty {
                        await getData()
                    }
                }

        }
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
        } catch {
            print("Invalid data")
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
