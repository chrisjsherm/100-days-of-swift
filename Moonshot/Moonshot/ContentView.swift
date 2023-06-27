//
//  ContentView.swift
//  Moonshot
//
//  Created by Christopher Sherman on 2023-06-22.
//

import SwiftUI

struct ContentView: View {
    let missionLayout: MissionLayout
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationView {
            Group {
                switch missionLayout {
                case .grid:
                    MissionGridView(astronauts: astronauts, missions: missions)
                case .list:
                    MissionListView(astronauts: astronauts, missions: missions)
                }
            }.navigationTitle("Moonshot")
                .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(missionLayout: MissionLayout.grid)
    }
}
