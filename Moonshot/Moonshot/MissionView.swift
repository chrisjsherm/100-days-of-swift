//
//  MissionView.swift
//  Moonshot
//
//  Created by Christopher Sherman on 2023-06-26.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    @State private var currentIndex = 0
    
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                        .padding(.bottom)
                    
                    Text("Launched \(mission.formattedLaunchDate)")
                        .font(.caption)
                }
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.lightBackground)
                    .padding(.vertical)
                
                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    HStack {
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 80)
                                            .clipShape(Capsule())
                                            .glow(color: .blue, radius: 20)
                                            .padding()

                                        VStack(alignment: .leading) {
                                            Text(crewMember.astronaut.name)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            
                                            Text(crewMember.role)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.horizontal)
                                    .id(crewMember.astronaut.id)
                                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    cancelTimer()
                                })
                            }
                        }
                        .simultaneousGesture(
                            DragGesture()
                                .onChanged { value in
                                    cancelTimer()
                                }
                        )
                    }
                    .onReceive(timer) { _ in
                        currentIndex = (currentIndex + 1) % crew.count
                        
                        if currentIndex == 0 {
                            cancelTimer()
                        }
                        
                        withAnimation(.linear(duration: 3)) {
                            scrollProxy.scrollTo(crew[currentIndex].astronaut.id)
                        }
                    }
                }
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.lightBackground)
                    .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    func cancelTimer() {
        self.timer.upstream.connect().cancel()
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
