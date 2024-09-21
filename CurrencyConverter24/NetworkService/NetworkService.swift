//
//  NetworkService.swift
//  CurrencyConverter24
//
//  Created by Borys Klykavka on 21.09.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case serverError(Any)
    case invalidJson
    case unsupportedContentType
}

class NetworkService {
    
    private let scheme = "https"
    private let host = "api.metalpriceapi.com"
    private let apiKey = ConfigValues.get().AccessKeys.apiAccessKey
    
    
    public static let shared = NetworkService()
    private init() {}
    
    private func formatComponents(apiEndpoint: APIEndpoints) -> URLComponents{
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = apiEndpoint.path
        return components
    }
    
    private func formatQueryItems(apiEndpoint: APIEndpoints,
                                  currency: String? = nil,
                                  fromCurrency: String? = nil,
                                  toCurrency: String? = nil,
                                  amount: String? = nil,
                                  weight: String? = nil,
                                  startDate: String? = nil,
                                  endDate: String? = nil) -> [URLQueryItem] {
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        switch apiEndpoint {
        case .symbols:
            queryItems.append(URLQueryItem(name: "type", value: currency));
        case .latest:
            return [URLQueryItem(name: "base", value: currency)];
        case .historical:
            return [];
        case .convert:
            queryItems.append(URLQueryItem(name: "from", value: fromCurrency ?? "USD"));
            queryItems.append(URLQueryItem(name: "to", value: toCurrency ?? "XAU"));
            queryItems.append(URLQueryItem(name: "amount", value: amount ?? "10"));
            return queryItems
        case .timeframe:
            queryItems.append(URLQueryItem(name: "start", value: startDate ?? "2023-01-01"));
            queryItems.append(URLQueryItem(name: "end", value: endDate ?? "2024-01-01"));
            return queryItems
        case .change:
            queryItems.append(URLQueryItem(name: "currency", value: currency))
        case .carat:
            queryItems.append(URLQueryItem(name: "type", value: currency))
        }
        
        return queryItems
    }
    
    func sendRequest(apiEndpount: APIEndpoints,
                     currency: String? = nil,
                     fromCurrency: String? = nil,
                     toCurrency: String? = nil,
                     amount: String? = nil,
                     weight: String? = nil,
                     startDate: String? = nil,
                     endDate: String? = nil,
                     completion: @escaping (Result<Any, Error>) -> Void) {
        
        var components = formatComponents(apiEndpoint:apiEndpount)
        let quertyItems = formatQueryItems(apiEndpoint: .convert,
                                           currency: currency,
                                           fromCurrency:fromCurrency,
                                           toCurrency: toCurrency,
                                           amount: amount,
                                           weight: weight,
                                           startDate: startDate,
                                           endDate: endDate)
        components.queryItems = quertyItems

        guard let url = components.url else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        print(url)
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                 completion(.failure(NetworkError.invalidResponse))
                return
            }
            let contentType = httpResponse.allHeaderFields["Content-Type"] as? String ?? ""
               
            if contentType.contains("application/json"), let data = data {
                   do {
                       let json = try JSONSerialization.jsonObject(with: data, options: [])
                       if (200...299).contains(httpResponse.statusCode) {
                           completion(.success(json))
                       } else {
                           completion(.failure(NetworkError.serverError(json)))
                       }
                   } catch {
                       completion(.failure(NetworkError.invalidJson))
                   }
               } else {
                   completion(.failure(NetworkError.unsupportedContentType))
               }
        }            
        task.resume()
    }
}
