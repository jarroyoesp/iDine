//
//  iDineApp.swift
//  iDine
//
//  Created by Danijel Lasic on 26.05.25.
//

import SwiftUI

@main
struct iDineApp: App {
    @StateObject var order = Order() // *D* note `@StateObject` means we just created an instance which will be treated as an "environment object", available for reading and manipulation to anyone who can access it

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order) // *D* note, this passes the environment object `order` into the `ContentView`.
        }
    }
}
