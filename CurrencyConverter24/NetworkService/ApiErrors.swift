//
//  ApiErrors.swift
//  CurrencyConverter24
//
//  Created by Borys Klykavka on 21.09.2024.
//

enum APIError: Int, Error {
    case functionNotFound = 404                 // User requested a non-existent API function
    case missingAPIKey = 101                    // User did not supply an API Key
    case invalidAccessKey = 102                 // User did not supply an access key or supplied an invalid access key
    case accountNotActive = 103                 // The user's account is not active. User will be prompted to get in touch with Customer Support
    case tooManyRequests = 104                  // Too Many Requests
    case exceededRequestLimit = 105             // User has reached or exceeded his subscription plan's monthly API request allowance
    case invalidBaseCurrency = 201              // User entered an invalid Base Currency [ latest, historical, timeframe, change ]
    case invalidFromCurrency = 202              // User entered an invalid from Currency [ convert ]
    case invalidToCurrency = 203                // User entered invalid to currency [ convert ]
    case invalidAmount = 204                    // User entered invalid amount [ convert ]
    case invalidDate = 205                      // User entered invalid date [ historical, convert, timeframe, change ]
    case invalidTimeframe = 206                 // Invalid timeframe [ timeframe, change ]
    case timeframeExceeded = 207                // Timeframe exceeded 365 days [ timeframe ]
    case noResults = 300                        // The user's query did not return any results [ latest, historical, convert, timeframe, change ]
    
    var description: String {
        switch self {
        case .functionNotFound:
            return "User requested a non-existent API function"
        case .missingAPIKey:
            return "User did not supply an API Key"
        case .invalidAccessKey:
            return "User did not supply an access key or supplied an invalid access key"
        case .accountNotActive:
            return "The user's account is not active. Please contact Customer Support."
        case .tooManyRequests:
            return "Too many requests. Please try again later."
        case .exceededRequestLimit:
            return "You have reached or exceeded your subscription plan's monthly API request allowance."
        case .invalidBaseCurrency:
            return "User entered an invalid Base Currency."
        case .invalidFromCurrency:
            return "User entered an invalid 'from' currency."
        case .invalidToCurrency:
            return "User entered an invalid 'to' currency."
        case .invalidAmount:
            return "User entered an invalid amount."
        case .invalidDate:
            return "User entered an invalid date."
        case .invalidTimeframe:
            return "Invalid timeframe provided."
        case .timeframeExceeded:
            return "Timeframe exceeded 365 days."
        case .noResults:
            return "The user's query did not return any results."
        }
    }
}
