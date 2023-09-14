import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                        GeometryReader { geo in
                        
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[abs(
                                Int(
                                    geo.frame(in: .global).minY / geo.size.height - 1.0
                                ) % 7)
                            ])
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(geo.frame(in: .global).maxY / fullView.size.height)
                            .scaleEffect(
                                geo.frame(in: .global).maxY / fullView.size.height + 0.5
                            )
                            .onTapGesture {
                                print("Item height: \(geo.size.height)")
                                print("Index \(index) maxY: \(geo.frame(in: .global).maxY)")
                                print("View height: \(fullView.size.height)")
                                let colorIdx = Int(
                                    geo.frame(in: .global).minY / geo.size.height - 1.0
                                ) % 7
                                
                                print("Color index: \(colorIdx)")
                            }
                    }
                    .frame(height: 40)
                    
                }
            }
        }
    }
}
