import SwiftUI

struct ContentView: View {
    private var messages: [String]
    
    init() {
        messages = []
        
        printTimesTables(for: 5)
    }
    
    mutating func printTimesTables(for number: Int) {
        for i in 1...12 {
            let msg = "\(i) x \(number) is \(i * number)"
            messages.append(msg)
        }
    }
   
    var body: some View {
         ScrollView {
            VStack {
                ForEach(messages, id: \.self) { entry in
                    Text(entry)
                }
            }
        }
    }
}
