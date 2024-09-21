//
//  ConvertResponseData.swift
//  CurrencyConverter24
//
//  Created by Borys Klykavka on 21.09.2024.
//


import Foundation

// MARK: - Welcome
struct ConvertResponseData: Codable {
    let success: Bool
    let query: Query
    let info: Info
    let result: Double
}

// MARK: - Info
struct Info: Codable {
    let quote: Double
    let timestamp: Int
}

// MARK: - Query
struct Query: Codable {
    let from, to: String
    let amount: Int
}
