import SwiftUI

struct ContentView: View {
    @State var logEntry: [String]
    
    init() {
        self.logEntry = [String]()
    }
    
    func logTimestamp() -> Void {
        let timestamp = String(Date().currentTimeMillis())
        print(timestamp)
        logEntry.append(timestamp)
    }
   
    var body: some View {
        VStack{
            Button("Log current timestamp") {
                logTimestamp()
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
