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
    
    
    /// Parse iso date string to the given format
    /// - Parameter format: the output date format
    /// - Returns: the new date formatted as string
    func parseISODateString(to format: String = "MMM YYYY") -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss'Z'"
        let date = formatter.date(from: self) ?? Date()
        
        let monthYearFormatter = DateFormatter()
        monthYearFormatter.dateFormat = format
        let dateString = monthYearFormatter.string(from: date)
        return dateString
    }
    
}
