//
//  ContentView.swift
//  Bucket List
//
//  Created by Christopher Sherman on 2023-08-04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                let fileName = "message.txt"

                do {
                    try FileManager.default.writeToStorage(fileName: fileName, value: str)
                    let input = try FileManager.default.readFromStorage(fileName: fileName)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
