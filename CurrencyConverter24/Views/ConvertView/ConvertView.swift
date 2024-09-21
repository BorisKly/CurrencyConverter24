//
//  ConvertView.swift
//  CurrencyConverter24
//
//  Created by Borys Klykavka on 21.09.2024.
//

import SwiftUI

struct ConvertView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    
    @State private var isBaseCurrencyPickerVisible: Bool = false
    @State private var isQuoteCurrencyPickerVisible: Bool = false
 

    var body: some View {
        VStack{
            VStack (spacing: 30){
                Spacer()
                TextField("Choose base currency",
                          text: .constant(viewModel.selectedBaseCurrency.code))
                .onTapGesture {
                    isBaseCurrencyPickerVisible.toggle()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                if isBaseCurrencyPickerVisible {
                    Picker("Choose currency", selection: $viewModel.selectedBaseCurrency) {
                        ForEach(currencies, id: \.self) { currency in
                            Text(currency.name).tag(currency)
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                    .onChange(of: viewModel.selectedBaseCurrency) { _ in
                        isBaseCurrencyPickerVisible = false
                    }
                }
                Text("to")
                TextField("Choose Quote currency",
                          text: .constant(viewModel.selectedQuoteCurrency.code))
                .onTapGesture {
                    isQuoteCurrencyPickerVisible.toggle()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                if isQuoteCurrencyPickerVisible {
                    Picker("Choose currency", selection: $viewModel.selectedQuoteCurrency) {
                        ForEach(currencies, id: \.self) { currency in
                            Text(currency.name).tag(currency)
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                    .onChange(of: viewModel.selectedQuoteCurrency) { _ in
                        isQuoteCurrencyPickerVisible = false
                    }
                }
                TextField("Amoun", text: $viewModel.amount)
                                .keyboardType(.numberPad)
                                .onChange(of: viewModel.amount) { newValue in
                                    if let number = Int(newValue), number < 1 {
                                        viewModel.amount = ""
                                    }
                                }
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.top)
                Button(action: {
                    viewModel.handleButtonClick()
                }){
                    Text("Convert")
                        .padding()
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                }
                .frame(width: 200)
                .background(.green)

                if viewModel.formattedAmount != "" {
                    Text("\(viewModel.amount) \(viewModel.selectedBaseCurrency.code) costs \(viewModel.formattedAmount) \(viewModel.selectedQuoteCurrency.code)")
                        .padding()
                }
                Spacer()
            }
            .padding(20)
        }
        .background(.cyan)
        
    }
}

#Preview {
    ConvertView()
}
