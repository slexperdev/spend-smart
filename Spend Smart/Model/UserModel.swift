//
//  UserModel.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-21.
//


import Foundation

struct User : Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    let currency: String
    let currencyName: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}
