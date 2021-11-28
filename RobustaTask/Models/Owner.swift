//
//  Owner.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 28/11/2021.
//

import Foundation


class Owner: Decodable
{
    var id: Int
    var login: String
    var avatarUrl: String
    var followersUrl: String
    var followingUrl: String
    var url: String
    var type: String
    var siteAdmin: Bool
    var htmlUrl: String
}

