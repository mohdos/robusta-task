//
//  Repository.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 28/11/2021.
//

import Foundation


class Repository: Decodable
{
    var owner: Owner
    var id: Int
    var nodeId: String
    var name: String
    var fullName: String
    var `private`: Bool
    var description: String?
    var htmlUrl: String
    var url: String
    var fork: Bool
}

class RepositorySearch: Decodable { // because searching returns the array of repositories with key items
    var items: [Repository]
}
