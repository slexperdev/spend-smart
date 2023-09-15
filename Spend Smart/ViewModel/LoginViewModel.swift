//
//  LoginViewModel.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-08.
//

import Foundation

class LoginViewModel : ObservableObject {
    @Published var email : String = ""
    @Published var password : String = ""
}

