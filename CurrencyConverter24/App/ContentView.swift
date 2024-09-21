//
//  ContentView.swift
//  CurrencyConverter24
//
//  Created by Borys Klykavka on 21.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        NavigationStack {
            List(APIEndpoints.allCases, id: \.self) { endpoint in
                NavigationLink(destination: viewForEndpoint(endpoint)) {
                    Text(endpoint.name)
                }
            }
            .navigationTitle("Actions")
        }
    }
    @ViewBuilder
        func viewForEndpoint(_ endpoint: APIEndpoints) -> some View {
            switch endpoint {
            case .symbols:
                SymbolsView()
            case .latest:
                LatestView()
            case .historical:
                HistoricalView()
            case .convert:
                ConvertView()
            case .timeframe:
                TimeframeView()
            case .change:
                ChangeView()
            case .carat:
                CaratView()
            }
        }
}
#Preview {
    ContentView()
}
