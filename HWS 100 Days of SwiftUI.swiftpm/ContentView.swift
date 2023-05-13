import SwiftUI

struct ContentView: View {
    
    init() {
        
        func hello(arr: [Int]?) -> Int { return arr?[Int.random(in: 0..<(arr!.count))] ?? Int.random(in: 1...100)}
        print(hello(arr: nil))
    }
    
    var body: some View {
        Text("Checkpoint 9")
    }
}
