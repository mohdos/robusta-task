//
//  CustomErrors.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 28/11/2021.
//

import Foundation


enum CustomErrors: Error, CustomStringConvertible
{
    case unknownError
    case invalidURL
    case custom(description: String)
    
    var description: String {
        switch self {
        case .unknownError:
            return "Unknown error occured"
        case .invalidURL:
            return "Error parsing URL"
        case .custom(let description):
            return description
        }
    }
}
