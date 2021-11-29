//
//  ContextManager.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//

import Foundation
import UIKit
import CoreData

class ContextManager
{
    public static var appDelegate: AppDelegate? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print(CustomErrors.unknownError)
            return nil
        }
        return appDelegate
    }()
    
    public static var viewContext: NSManagedObjectContext? = {
        return ContextManager.appDelegate?.persistentContainer.viewContext
    }()
    
    public static var backgroundContext: NSManagedObjectContext? = {
        return ContextManager.appDelegate?.persistentContainer.newBackgroundContext()
    }()
}
