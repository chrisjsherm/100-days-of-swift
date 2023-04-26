import SwiftUI

struct ContentView: View {
    private let tempCelcius: Double
    
    init(tempCelcius: Double) {
        self.tempCelcius = tempCelcius
    }
    
    private func convertToFahrenheit(celciusVal: Double) -> String {
        let fahrenheitVal = celciusVal * 9.0 / 5.0 + 32.0
        
        return String(format: "%.1f", fahrenheitVal)
    }
  
    var body: some View {
        VStack {
            Image(systemName: "thermometer.sun")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Text("Temperature: \(convertToFahrenheit(celciusVal: tempCelcius))°F")
        }
    }
}
