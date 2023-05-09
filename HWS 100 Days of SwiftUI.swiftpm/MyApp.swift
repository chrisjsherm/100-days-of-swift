import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(car: Car(model: "Honda S2000", numberOfSeats: 2, gearCount: 5, currentGear: 1))
        }
    }
}
