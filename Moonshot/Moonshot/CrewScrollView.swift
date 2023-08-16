//
//  CrewScrollView.swift
//  Moonshot
//
//  Created by Christopher Sherman on 2023-06-27.
//

import SwiftUI

struct CrewScrollView: View {
    var crew: Array<CrewMember>
    
    @State private var currentIndex = 0
    
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    var body: some View {
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
                                    .accessibilityLabel("\(crewMember.astronaut.name) profile photo")

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
                
                withAnimation {
                    scrollProxy.scrollTo(crew[currentIndex].astronaut.id)
                }
            }
        }
    }
    
    func cancelTimer() {
        self.timer.upstream.connect().cancel()
    }
}

struct CrewScrollView_Previews: PreviewProvider {
    @State static var crew: [CrewMember] = []
    
    static var previews: some View {
        CrewScrollView(crew: crew)
    }
}
