//
//  ContentView.swift
//  Bucket List
//
//  Created by Christopher Sherman on 2023-08-04.
//

import SwiftUI

struct ContentView: View {
    var loadingState = LoadingState.Loading
    
    var body: some View {
        switch (loadingState) {
        case .Loading:
            LoadingView()
            
        case .Success:
            SuccessView()
            
        case .Error:
            ErrorView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
