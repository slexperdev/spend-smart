//
//  ExpenseModel.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-28.
//

import Foundation

struct Transaction : Identifiable, Codable {
    let id: String
    let title: String
    let type: String
    let remark: String
    let category: String
    let amount: Double
    let createdOn: Date
}
