//
//  Repository.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 28/11/2021.
//

import Foundation
import CloudKit
import UIKit
import CoreData

class RepositoryDec: Decodable
{
    static var entity: NSEntityDescription? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error")
            return nil
        }
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Repository", in: context) else {
            print("Error retreiving entity")
            return nil
        }
        return entity
    }()
    
    var owner: OwnerDec
    var id: Int
    var nodeId: String
    var name: String
    var fullName: String
    var description: String?
    var htmlUrl: String
    var url: String
    var createdAt: String?
    
    internal init(owner: OwnerDec, id: Int, nodeId: String, name: String, fullName: String, description: String? = nil, htmlUrl: String, url: String, createdAt: String? = nil) {
        self.owner = owner
        self.id = id
        self.nodeId = nodeId
        self.name = name
        self.fullName = fullName
        self.description = description
        self.htmlUrl = htmlUrl
        self.url = url
        self.createdAt = createdAt
    }
    
    
    /// Saves an array of repositories to core data
    /// - Parameter repos: array of repositories to be saved
    static func saveReposToCoreData(repos: [RepositoryDec])
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Repository", in: context) else {
            print("Error retreiving entity")
            return
        }
        
        
        for repo in repos {
            repo.owner.save()
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(repo.id, forKey: "id")
            managedObject.setValue(repo.description, forKey: "repoDescription")
            managedObject.setValue(repo.fullName, forKey: "fullName")
            managedObject.setValue(repo.htmlUrl, forKey: "htmlUrl")
            managedObject.setValue(repo.url, forKey: "url")
            managedObject.setValue(repo.owner, forKey: "owner")
            managedObject.setValue(repo.createdAt, forKey: "createdAt")
        }
        
        do {
            try context.save()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    /// Saves the current repository object to core data
    func save()
    {
        RepositoryDec.saveReposToCoreData(repos: [self])
    }
    
    /// Check if a repo is already saved
    /// - Parameter id: id of the repo
    /// - Returns: a boolean indicating if the repo is already saved to core data or not
    static func isSaved(id: Int) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error retrieving app delegate")
            return false
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Repository")
        fetchRequest.predicate = NSPredicate(format: "id = %d", argumentArray: [Int64(id)])

        do {
            let res = try context.fetch(fetchRequest)
            return res.count > 0 ? true : false
        }
        catch let error
        {
            print(error.localizedDescription)
            return false
        }
    }
    
    
    func getRepos(offset: Int = 0, limit: Int = 10) -> [RepositoryDec] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error")
            return []
        }
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Repository", in: context) else {
            print("Error retreiving entity")
            return []
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Repository")
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = offset
        fetchRequest.entity = entity
        let fetchedObjects: [RepositoryDec]? = try? context.fetch(fetchRequest) as? [RepositoryDec]
        return fetchedObjects ?? []
    }
    
}

class RepositorySearch: Decodable { // because searching returns the array of repositories with key items
    var items: [Repository]
}

/*
 enum CodingKeys: CodingKey {
     case id,
     name,
     fullName,
     repoDescription,
     url,
     createdAt,
     htmlUrl,
     openIssuesCount,
     subscribersCount,
     forksCount,
     size,
     owner
 }
 
 */
