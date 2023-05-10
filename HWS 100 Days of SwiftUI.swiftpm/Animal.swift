//
//  Animal.swift
//  HWS 100 Days of SwiftUI
//
//  Created by Christopher Sherman on 2023-05-10.
//

import Foundation

class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() -> String {
        return "Roof"
    }
}

class Corgi: Dog {
    override func speak() -> String {
        return "Yip"
    }
}

class Poodle: Dog {
    override func speak() -> String {
        return "Arf"
    }
}

class Cat: Animal {
    let isTame: Bool
    
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(legs: legs)
    }
    
    func speak() -> String {
        return "Meow"
    }
}

class Persian: Cat {
    override func speak() -> String {
        return "Prrr"
    }
}

class Lion: Cat {
    override func speak() -> String {
        return "Roar"
    }
}
