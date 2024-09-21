//
//  CurrencyConverter24App.swift
//  CurrencyConverter24
//
//  Created by Borys Klykavka on 21.09.2024.
//

import SwiftUI

@main
struct CurrencyConverter24App: App {
    
    @StateObject var viewModel = ContentViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
