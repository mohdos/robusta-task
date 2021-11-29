//
//  Repository+CoreDataClass.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//
//

import Foundation
import CoreData
import UIKit


public class Repository: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id,
        name,
        fullName,
        repoDescription = "description",
        url,
        createdAt,
        htmlUrl,
        openIssuesCount,
        subscribersCount,
        forksCount,
        size,
        owner
    }
    
    private struct Owner: Decodable {
        var id: Int
        var login: String
        var htmlUrl: String
        var avatarUrl: String
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw CustomErrors.missingManagedObjectContext
        }

        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName)
        self.repoDescription = try container.decodeIfPresent(String.self, forKey: .repoDescription)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
        self.openIssuesCount = try container.decodeIfPresent(Int64.self, forKey: .openIssuesCount) ?? -1
        self.subscribersCount = try container.decodeIfPresent(Int64.self, forKey: .subscribersCount) ?? -1
        self.forksCount = try container.decodeIfPresent(Int64.self, forKey: .forksCount) ?? -1
        self.size = try container.decodeIfPresent(Int64.self, forKey: .size) ?? -1
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        
        let owner: Owner? = try container.decodeIfPresent(Owner.self, forKey: .owner)
        self.ownerId = Int64(owner?.id ?? -1)
        self.ownerLogin = owner?.login
        self.ownerHtmlUrl = owner?.htmlUrl
        self.ownerAvatarUrl = owner?.avatarUrl
    }
    
    /// Updates the current object to core data
    func update()
    {
        do {
            try self.managedObjectContext?.save()
        }
        catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    /// Inserts the current object to core data
    func insert()
    {
//        if self.url != nil && self.isRepoInserted(url: self.url!) {
//            return
//        }
        if self.isInserted {
            return
        }
        self.update()
    }
    
    func getRepoByUrl(url: String) -> Repository?
    {
        let context = ContextManager.viewContext!
        let request = Repository.fetchRequest()
        request.predicate = NSPredicate(format: "url = %@", argumentArray: [url])
        let repo = try? context.fetch(request).first
        return repo
    }
    
    func isRepoInserted(url: String) -> Bool
    {
        return getRepoByUrl(url: url) != nil
    }
    
    
    /// Save an array of repositories
    /// - Parameter repos: array of repositories to save
    static func saveRepos(repos: [Repository])
    {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            print(CustomErrors.unknownError)
//            return
//        }
        
//        let context = appDelegate.persistentContainer.newBackgroundContext()
//        context.automaticallyMergesChangesFromParent = true
        
        for repo in repos {
//            repo.save()
            repo.insert()
        }
        
    }
    
    
    /// Fetch saved repositories
    /// - Parameters:
    ///   - offset: the offset by which to get data
    ///   - limit: the limit of the results returned
    ///   - completion: handle the returned repositories
    /// - Returns: array of repositories
    static func fetchSavedRepos(offset: Int = 0, limit: Int = 10, _ completion: (([Repository]) -> Void)?)
    {
        if offset >= 90 {
            completion?([])
        }
        let context = ContextManager.viewContext!
//        let context = ContextManager.viewContext!
        context.automaticallyMergesChangesFromParent = true
        context.perform {
            do {
//                let numberOfSavedRepos = Repository.getNumberOfSavedRepos()
//                if (numberOfSavedRepos <= offset) {
//                    completion?([])
//                    return
//                }
                let request = Repository.fetchRequest()
                request.fetchLimit = limit
                request.fetchOffset = offset
//                request.includesPendingChanges = false
                
                let repos = try context.fetch(request)
                completion?(repos)
//                try? context.save()
            }
            catch let error {
                print(error.localizedDescription)
                completion?([])
            }
        }
    }
    
    
    /// Gets the number of repositories saved to core data
    /// - Returns: the number of repositories saved to core data
    static func getNumberOfSavedRepos() -> Int
    {
        let fetchRequest = Repository.fetchRequest()
        let count = try? ContextManager.viewContext!.count(for: fetchRequest)
        return count ?? 0
    }
    
    /// Deletes all repositories saved
    static func deleteAllData()
    {
        let context = ContextManager.viewContext!
        let fetchRequest = Repository.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                context.delete(object)
            }
            try context.save()
        } catch let error {
            print("Detele all data error: ", error.localizedDescription)
        }
    }
    
}


