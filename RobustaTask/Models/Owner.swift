//
//  Owner.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 28/11/2021.
//

import Foundation
import UIKit
import CoreData

class OwnerDec: Decodable
{
    var id: Int
    var login: String
    var avatarUrl: String
    var url: String
    
    internal init(id: Int, login: String, avatarUrl: String, url: String) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
        self.url = url
    }
    
    /// Saves an array of owners to core data
    /// - Parameter repos: array of owners to be saved
    static func saveOwnersToCoreData(owners: [OwnerDec])
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Owner", in: context) else {
            print("Error retreiving entity")
            return
        }
        
        for owner in owners {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(Int64(owner.id), forKey: "id")
            managedObject.setValue(owner.login, forKey: "login")
            managedObject.setValue(owner.url, forKey: "url")
            managedObject.setValue(owner.avatarUrl, forKey: "avatarUrl")
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
        if OwnerDec.isSaved(id: self.id)
        {
            return
        }
        OwnerDec.saveOwnersToCoreData(owners: [self])
    }
    
    
    /// Check if an owner is already saved
    /// - Parameter id: id of the owner
    /// - Returns: a boolean indicating if the owner is already saved to core data or not
    static func isSaved(id: Int) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error retrieving app delegate")
            return false
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Owner")
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
}

