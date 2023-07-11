//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Christopher Sherman on 2023-07-10.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: OrderRequest
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.data.name)
                TextField("Street Address", text: $order.data.streetAddress)
                TextField("City", text: $order.data.city)
                TextField("Zip", text: $order.data.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.data.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderRequest())
    }
}
