//
//  CategoryModel.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-24.
//

import Foundation

struct Category : Identifiable, Codable {
    let id: String
    let category: String
    let color: String
}
