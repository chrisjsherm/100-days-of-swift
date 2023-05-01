import SwiftUI

struct ContentView: View {
    let temperatureFormat = "%.1f"
    
    @State private var currentDay: String
    @State private var entryCount: Int
    @State private var history: [Int: String]
    @State private var isFahrenheit: Bool
    @State private var tempCelcius: Double
    @State private var tempOccurrences: Set<String>
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(tempCelcius: Double) {
        self.currentDay = ""
        self.entryCount = 0;
        self.history = [:]
        self.isFahrenheit = true
        self.tempCelcius = tempCelcius
        self.tempOccurrences = Set<String>()
    }
    
    private func fireTimer() {
        let day = Calendar.current.component(.weekday, from: Date())
        
        switch (day) {
        case DayOfWeek.Sunday.rawValue:
            currentDay = "Start of the week"
        case DayOfWeek.Thursday.rawValue:
            currentDay = "Thursday :)"
        default:
            currentDay = "Day"
        }
    }
    
    private func convertToFahrenheit(celciusVal: Double) -> Double {
        return celciusVal * 9.0 / 5.0 + 32.0
    }
    
    private func decrementTemp() {
        tempCelcius -= 1;
        logTemperature()
    }
    
    private func getDisplayTemperature() -> String {
        if (isFahrenheit) {
            let valueToDisplay = convertToFahrenheit(celciusVal: tempCelcius)
            return String(format: temperatureFormat, valueToDisplay)
        }
        
        return String(format: temperatureFormat, tempCelcius)
    }
    
    private func incrementTemp() {
        tempCelcius += 1;
        logTemperature()
    }
    
    private func logTemperature() {
        entryCount += 1
        let val: String = getDisplayTemperature()
        history[entryCount] = val
        tempOccurrences.insert(val)
    }
  
    var body: some View {
        VStack {
            Image(systemName: "thermometer.sun")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("\(getDisplayTemperature())°\(isFahrenheit ? "F" : "C")")
            
            Text("\(currentDay)")
                .onReceive(timer) { _ in
                    let day = Calendar.current.component(.weekday, from: Date())
                    
                    switch (day) {
                    case DayOfWeek.Sunday.rawValue:
                        currentDay = "Start of the week"
                    case DayOfWeek.Thursday.rawValue:
                        currentDay = "Thursday :)"
                    default:
                        currentDay = "Day \(day)"
                    }
                }
            
            Toggle("Convert to Fahrenheit", isOn: $isFahrenheit)
            
            HStack {
                Button("Increment") {
                    incrementTemp()
                }

                Button("Decrement") {
                    decrementTemp()
                }
            }
            .padding(.top)
            
            VStack {
                Text("Has 95.0°F occurred?")
                Text("\(tempOccurrences.contains("95.0") ? "Yes" : "No")")
                    .font(.callout)
                
                Spacer()
                
                Text("\(tempOccurrences.count) unique temperature occurrences")
                Text("\(history.count) temperatures logged")
            }.padding(.top)
                .onAppear() {
                    logTemperature()
                }
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(history.sorted(by: >), id: \.key) { key, value in
                        Text("Entry #\(key): \(value)°F")
                    }
                    .padding(.top)
                }
            }
        }
    }
}
