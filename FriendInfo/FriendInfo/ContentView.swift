//
//  ContentView.swift
//  FriendInfo
//
//  Created by Christopher Sherman on 2023-07-21.
//

import SwiftUI

struct ContentView: View {
    @State private var friends = [Friend]()
    
    var body: some View {
        NavigationView {
                List {
                    if friends.count > 0 {
                        ForEach(friends) { friend in
                            NavigationLink {
                                FriendDetailView(friend: friend)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(friend.name)
                                        .font(.headline)
                                        .padding(.bottom, 2)
                                    Text(friend.company).font(.subheadline)
                                    Text(friend.email).font(.subheadline)
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
            print(decodedResponse)
            friends = decodedResponse
            
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
