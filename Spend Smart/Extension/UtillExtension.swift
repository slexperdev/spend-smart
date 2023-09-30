//
//  UtillExtension.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-29.
//

import Foundation

extension Date {
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
}

extension Double {
    func formattedPrice() -> String {
        let total = String(format: "%.2f", self)
        return total
    }
}
