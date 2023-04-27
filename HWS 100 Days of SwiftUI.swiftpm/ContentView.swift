import SwiftUI

struct ContentView: View {
    let temperatureFormat = "%.1f"
    
    @State private var history = [Int: String]()
    @State private var tempCelcius: Double
    @State private var entryCount: Int = 0
        
    init(tempCelcius: Double) {
        self.tempCelcius = tempCelcius
    }
    
    private func convertToFahrenheit(celciusVal: Double) -> Double {
        return celciusVal * 9.0 / 5.0 + 32.0
    }
    
    private func decrementTemp() {
        tempCelcius -= 1;
        logTemperature()
    }
    
    private func getDisplayTemperature() -> String {
        let valueToDisplay = convertToFahrenheit(celciusVal: tempCelcius)
        return String(format: temperatureFormat, valueToDisplay)
    }
    
    private func incrementTemp() {
        tempCelcius += 1;
        logTemperature()
    }
    
    private func logTemperature() {
        entryCount += 1
        let val: String = getDisplayTemperature()
        history[entryCount] = val
    }
  
    var body: some View {
        VStack {
            Image(systemName: "thermometer.sun")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Text(getDisplayTemperature())
            
            HStack {
                Button("Increment") {
                    incrementTemp()
                }

                Button("Decrement") {
                    decrementTemp()
                }
            }
            .padding(.top)
            
            ForEach(history.sorted(by: >), id: \.key) { key, value in
                Text("Entry #\(key): \(value)")
            }
            .padding(.top)
        }
    }
}
