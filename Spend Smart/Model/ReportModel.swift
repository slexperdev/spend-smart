//
//  ReportModel.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-29.
//

import Foundation

struct Report : Identifiable, Codable {
    let id: String
    let category: String
    let color: String
    let totalIncome: Double
    let totalExpense: Double
}
