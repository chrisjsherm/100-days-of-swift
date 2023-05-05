import SwiftUI

struct ContentView: View {
    @State var logEntry: [String]
    
    init() {
        self.logEntry = [String]()
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
