import SwiftUI

struct ContentView: View {
    private var messages: [String]
    
    init() {
        self.messages = [String]()
        for i in 1...100 {
            if i % 15 == 0 {
                messages.append("FizzBuzz")
            } else if i % 3 == 0 {
                messages.append("Fizz")
            } else if i % 5 == 0 {
                messages.append("Buzz")
            } else {
                messages.append(String(i))
            }
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
