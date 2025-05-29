//
//  MainView.swift
//  iDine
//
//  Created by Danijel Lasic on 27.05.25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }

            OrderView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }

            RandomTextView(viewModel: RandomTextViewModel())
                .tabItem {
                    Label("RandomText", systemImage: "circle")
                }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(Order())
}
