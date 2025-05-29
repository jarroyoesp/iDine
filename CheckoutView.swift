//
//  CheckoutView.swift
//  iDine
//
//  Created by Danijel Lasic on 27.05.25.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 15
    @State private var showingPaymentAlert = false
    @State private var pickupTime = ["Now", "Tonight", "Tomorrow"]

    let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    let tipAmounts = [10, 15, 20, 25, 0]

    var totalPrice: String {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(tipAmount)
        return (total + tipValue).formatted(.currency(code: "USD"))
    }

    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self) {
                        Text($0)
                    }
                }
                Toggle("Add iDine loyalty card", isOn: $addLoyaltyDetails.animation())
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            Section("Pickup time") {
                Picker("Percentage:", selection: $pickupTime) {
                    ForEach(pickupTime, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.segmented)
            }
            Section("Add a tip?") {
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(tipAmounts, id: \.self) {
                        Text("\($0)%")
                    }
                }
                .pickerStyle(.segmented)
            }
            Section("Total: \(totalPrice)") {
                Button("Confirm order") {
                    showingPaymentAlert.toggle()
                }
            }
            .alert("Order confirmed", isPresented: $showingPaymentAlert) {
                // add buttons here
            } message: {
                Text("Your total was \(totalPrice) – thank you!")
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CheckoutView()
        .environmentObject(Order())
}
