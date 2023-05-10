import SwiftUI

struct ContentView: View {
    let cat: Cat
    let dog: Dog
    let lion: Lion
    let persian: Persian
    let corgi: Corgi
    let poodle: Poodle
    
    init() {
        self.cat = Cat(legs: 4, isTame: false)
        self.dog = Dog(legs: 4)
        self.lion = Lion(legs: 4, isTame: false)
        self.persian = Persian(legs: 4, isTame: true)
        self.corgi = Corgi(legs: 4)
        self.poodle = Poodle(legs: 4)
    }
    
    var body: some View {
        VStack{
            Text("Cat speak: \(cat.speak())")
            Text("Dog speak: \(dog.speak())")
            Text("Lion speak: \(lion.speak())")
            Text("Persian speak: \(persian.speak())")
            Text("Corgi speak: \(corgi.speak())")
            Text("Poodle speak: \(poodle.speak())")
        }
    }
}
