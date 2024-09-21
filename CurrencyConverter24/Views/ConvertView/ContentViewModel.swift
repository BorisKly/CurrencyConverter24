//
//  ContentViewModel.swift
//  CurrencyConverter24
//
//  Created by Borys Klykavka on 21.09.2024.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    @Published var currency: String? = nil;
    @Published var weight: String? = nil;
    @Published var startDate: String? = nil;
    @Published var endDate: String? = nil;
    
    @Published var selectedBaseCurrency: Currency = currencies.first(where: { $0.code == "USD" }) ?? Currency(code: "", name: "")
    @Published var selectedQuoteCurrency: Currency = currencies.first(where: { $0.code == "EUR" }) ?? Currency(code: "", name: "")
    @Published var amount: String = ""
    @Published var formattedAmount: String = ""
    @Published var error: String?

    
    private func getData(completion: @escaping (Result<Any, Error>) -> Void) {
        NetworkService.shared.sendRequest(apiEndpount: .convert,
                                          fromCurrency: selectedBaseCurrency.code,
                                          toCurrency: selectedQuoteCurrency.code,
                                          amount: amount,
                                          completion: completion)
    }
    
    func handleButtonClick() {
        getData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    print("Received JSON Array: \(json)")
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(ConvertResponseData.self, from: jsonData)
                        self.formattedAmount = String(response.result)
                        print(self.formattedAmount)
                        
                    } catch {
                        print("Error decoding JSON: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            }
        }
    }
}
