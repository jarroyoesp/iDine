//
//  ItemDetail.swift
//  iDine
//
//  Created by Danijel Lasic on 26.05.25.
//

import SwiftUI

struct ItemDetail: View {
    let item: MenuItem
    @EnvironmentObject var order: Order // *D* note this is kind of a follow-up of the creation of the environment object with `@StateObject`. The `@EnvironmentObject` wrapper means SwiftUI will automatically look in its list of environment objects for something that is of type `Order`, and attach it to that property. It means we can access the environment object here (the one which we have created with the `@StateObject`. This is an "automatic attachment ability", but also tells SwiftUI to watch the object for any changes and refresh its UI when a change announcement comes through.

    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(4.0)
                    .clipped()
                    .padding()
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(.black)
                    .cornerRadius(4)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .offset(x: -25, y: -20)
            }
            Text(item.description)
                .padding()
            Button("Order This") {
                order.add(item: item)
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ItemDetail(item: MenuItem.example).environmentObject(Order())
    }
}
