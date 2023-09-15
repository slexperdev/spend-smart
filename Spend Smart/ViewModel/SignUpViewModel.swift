//
//  SignUpViewModel.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-12.
//

import Foundation

class SignUpViewModel : ObservableObject {
    @Published var navigateToSetCurrency : Bool = false
    
    @Published var name : String = ""
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var confirmPassword : String = ""
    @Published var currency : String = ""
    @Published var currencyName : String = "Sri Lanka Rupee"
    @Published var searchText : String = ""
}

