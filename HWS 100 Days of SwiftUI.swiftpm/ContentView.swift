import SwiftUI

struct ContentView: View {
    @State var car: Car
    @State var errorMessage: String = ""
    
    init(car: Car) {
        self.car = car
    }
   
    var body: some View {
        HStack {
            Button("Shift up") {
                do {
                    let _ = try car.shiftUp()
                    errorMessage = ""
                } catch GearShiftError.runtimeError(let errorDescription) {
                    errorMessage = errorDescription
                } catch {
                    errorMessage = "An unknown error occurred"
                }
                
            }
            
            Button("Shift down") {
                do {
                    let _ = try car.shiftDown()
                    errorMessage = ""
                } catch GearShiftError.runtimeError(let errorDescription) {
                    errorMessage = errorDescription
                } catch {
                    errorMessage = "An unknown error occurred"
                }
            }
        }
        
        VStack {
            Text("Current gear \(car.currentGear)")
            Text(errorMessage)
        }
    }
}
