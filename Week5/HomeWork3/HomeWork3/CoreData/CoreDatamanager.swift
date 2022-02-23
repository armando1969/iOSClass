//
//  CoreDatamanager.swift
//  HomeWork3
//
//  Created by Consultant on 2/22/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() { }
    
    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HomeWork3Model")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("something went wrong")
            }
        }
        return container
    }()
    
    var mainContext: NSManagedObjectContext { persistentContainer.viewContext }
    
    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
