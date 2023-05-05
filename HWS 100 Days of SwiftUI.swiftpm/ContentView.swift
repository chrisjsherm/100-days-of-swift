import SwiftUI

struct ContentView: View {
    @State var logEntry: [String]
    let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
    
    init() {
        self.logEntry = [String]()
        
        luckyNumbers.filter({(val: Int) -> Bool in
            return val % 2 != 0
        })
        .sorted(by: {(val1: Int, val2: Int) -> Bool in
            return val1 < val2
        })
        .map({(val: Int) -> String in
            return "\(val) is a lucky number"
        })
        .forEach({ (val: String) -> Void in
            print(val)
        })
    }
   
    var body: some View {
        VStack{
            Button("Log current timestamp") {
                { logEntry.append(String(Date().currentTimeMillis())) }()
            }
        }
        
         ScrollView {
            VStack {
                ForEach(logEntry, id: \.self) { entry in
                    Text(entry)
                }
                .padding(.bottom)
            }
        }
    }
}
