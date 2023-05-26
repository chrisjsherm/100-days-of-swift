//
//  FlagView.swift
//  GuessTheFlag
//
//  Created by Christopher Sherman on 2023-05-26.
//

import SwiftUI

struct FlagView: View {
    var country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagView(country: "US")
    }
}
