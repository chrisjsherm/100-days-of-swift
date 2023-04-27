import SwiftUI

struct ContentView: View {
    let temperatureFormat = "%.1f"
    
    @State private var history = [String]()
    @State private var tempCelcius: Double
        
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
        history.append(getDisplayTemperature())
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
        }
        
        List(history, id: \.self) { val in
            Text(val)
        }
    }
}
