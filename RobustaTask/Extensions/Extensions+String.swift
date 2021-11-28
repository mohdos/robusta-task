//
//  Extensions+String.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//

import Foundation

extension String {
    /// Converts the current string (camelCase) to snake_case
    /// - Returns: snake_case string
    func toSnakeCase() -> String {
        let pattern = "([a-z0-9])([A-Z])"

        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased() ?? self
    }
}
