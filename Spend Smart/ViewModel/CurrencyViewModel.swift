//
//  CurrencyViewModel.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-23.
//

import Foundation


class CurrencyViewModel : ObservableObject {
    @Published var searchText : String = ""
    @Published var currencies : [(name: String, code: String)] = [
        ("United States Dollar", "USD"),
        ("Australian Dollar", "AUD"),
        ("Sri Lanka Rupee", "LKR"),
        ("Euro", "EUR"),
        ("British Pound Sterling", "GBP"),
        ("Japanese Yen", "JPY"),
        ("Indian Rupee", "INR"),
        ]
    
    func getFilteredCurrencies() -> [(name: String, code: String)] {
            if searchText.isEmpty {
                return currencies
            } else {
                return currencies.filter { currency in
                    currency.name.localizedCaseInsensitiveContains(searchText) ||
                    currency.code.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
}
