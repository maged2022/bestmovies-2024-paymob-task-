//
//  CoreDataStack.swift
//  BestMovies
//
//  Created by maged on 17/05/2025.
//

import Foundation
import CoreData

// MARK: - CoreDataStack.swift
import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BestMoviesModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("❌ CoreData error: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("❌ Save failed: \(error)")
            }
        }
    }
}
