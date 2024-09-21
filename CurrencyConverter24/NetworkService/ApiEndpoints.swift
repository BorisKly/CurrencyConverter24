//
//  Endpoints.swift
//  CurrencyConverter24
//
//  Created by Borys Klykavka on 21.09.2024.
//
import Foundation


enum APIEndpoints: String, CaseIterable {
    
    case symbols = "symbols"
    case latest = "latest"
    case historical = "{date}"
    case convert = "convert"
    case timeframe = "timeframe"
    case change = "change"
    case carat = "carat"
    
    var path: String {
        let generalPath = #"/v1/"#
        return generalPath+self.rawValue
    }
    
    var name: String {
        switch self {
        case .symbols:
            "Symbols"
        case .latest:
            "Latest"
        case .historical:
            "Historical"
        case .convert:
            "Convert"
        case .timeframe:
            "Timeframe"
        case .change:
            "Change"
        case .carat:
            "Carat"
        }
    }
}



