import SwiftUI

struct ContentView: View {
    let building1: Building
    let building2: Building
    
    init() {
        building1 = House(rooms: 3, cost: 250000, agentName: "Bill")
        building2 = Office(rooms: 50, cost: 1000000, agentName: "Lucy")
    }
    
    var body: some View {
        VStack{
            Text("Building 1 summary: \(building1.printSalesSummary())")
            Text("Building 2 summary: \(building2.printSalesSummary())")
        }
    }
}
