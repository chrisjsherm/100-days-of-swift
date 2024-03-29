//
//  Helper-ForEachWithIndex.swift
//  Flashzilla
//
//  Created by Christopher Sherman on 2023-09-08.
//

import SwiftUI

struct ForEachWithIndex<
    Data: RandomAccessCollection,
    Content: View
>: View where Data.Element: Identifiable, Data.Element: Hashable {
    let data: Data
    @ViewBuilder let content: (Data.Index, Data.Element) -> Content

    var body: some View {
        ForEach(Array(zip(data.indices, data)), id: \.1) { index, element in
            content(index, element)
        }
    }
}
