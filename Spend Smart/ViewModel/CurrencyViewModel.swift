//
//  CurrencyViewModel.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-23.
//

import Foundation


class CurrencyViewModel : ObservableObject {
    @Published var searchText : String = ""
    
    //Currencies array
    @Published var currencies : [(name: String, code: String)] = [
        ("United States Dollar", "USD"),
        ("Australian Dollar", "AUD"),
        ("Sri Lanka Rupee", "LKR"),
        ("Euro", "EUR"),
        ("British Pound Sterling", "GBP"),
        ("Japanese Yen", "JPY"),
        ("Indian Rupee", "INR"),
        ("Canadian Dollar", "CAD"),
        ("Swiss Franc", "CHF"),
        ("Chinese Yuan", "CNY"),
        ("South Korean Won", "KRW"),
        ("Mexican Peso", "MXN"),
        ("New Zealand Dollar", "NZD"),
        ("Singapore Dollar", "SGD"),
        ("Hong Kong Dollar", "HKD"),
        ("Brazilian Real", "BRL"),
        ("South African Rand", "ZAR"),
        ("Russian Ruble", "RUB"),
        ("Saudi Riyal", "SAR"),
        ("United Arab Emirates Dirham", "AED"),
        ("Turkish Lira", "TRY"),
        ("Swedish Krona", "SEK"),
        ("Norwegian Krone", "NOK"),
        ("Danish Krone", "DKK"),
        ("Israeli New Shekel", "ILS"),
        ("Egyptian Pound", "EGP"),
        ("Malaysian Ringgit", "MYR"),
        ("Thai Baht", "THB"),
        ("Indonesian Rupiah", "IDR"),
        ("Philippine Peso", "PHP"),
        ("Vietnamese Dong", "VND"),
        ("Argentine Peso", "ARS"),
        ("Chilean Peso", "CLP"),
        ("Peruvian Sol", "PEN"),
        ("Colombian Peso", "COP"),
        ("Venezuelan Bolívar", "VES"),
        ("Nigerian Naira", "NGN"),
        ]
    
    //Filter currency
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
