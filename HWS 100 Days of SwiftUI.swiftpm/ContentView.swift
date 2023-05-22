import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("Cell 0")
                Text("Cell 1")
                Text("Cell 2")
            }
        }
        
        VStack {
            HStack {
                Text("Cell 3")
                Text("Cell 4")
                Text("Cell 5")
            }
        }
        
        VStack {
            HStack {
                Text("Cell 6")
                Text("Cell 7")
                Text("Cell 8")
            }
        }
    }
}
