//
//  Repository+CoreDataProperties.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//
//

import Foundation
import CoreData


extension Repository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var fullName: String?
    @NSManaged public var repoDescription: String?
    @NSManaged public var url: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var htmlUrl: String?
    @NSManaged public var openIssuesCount: Int64
    @NSManaged public var subscribersCount: Int64
    @NSManaged public var forksCount: Int64
    @NSManaged public var size: Int64
    @NSManaged public var ownerId: Int64
    @NSManaged public var ownerLogin: String?
    @NSManaged public var ownerAvatarUrl: String?
    @NSManaged public var ownerHtmlUrl: String?

}

extension Repository : Identifiable {

}
