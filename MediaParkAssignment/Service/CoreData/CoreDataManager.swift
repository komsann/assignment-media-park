//
//  CoreDataManager.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 8/2/22.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol: AnyObject {
  
  typealias CompletionBlock = ((Error?) -> Void)?
  
  func findObject<T>(for entity: T.Type,
                     entityName: String,
                     predicate: NSPredicate) -> T?
  
  func fetchOne<T>(from entity: String,
                   predict: NSPredicate,
                   success: (T?) -> Void,
                   failure: CompletionBlock)
  
  func save(completion: CompletionBlock)
  func deleteAll(from entity: String,completion: CompletionBlock)
}

class CoreDataManager: NSObject {
  
  var managerObjectContext: NSManagedObjectContext
  
  init(complectionBlock: @escaping () -> ()) {
    guard let modelURL = Bundle.main.url(forResource: "CoreDataModel", withExtension: "momd") else {
      fatalError("Error loading model")
    }
    
    guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
      fatalError("Error initializing mom from url: \(modelURL)")
    }
    
    let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
    managerObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    managerObjectContext.persistentStoreCoordinator = psc
    
    let queue = DispatchQueue.global(qos: .background)
    queue.async {
      guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
        fatalError("Unalbe to resolve document directory")
      }
      let storeURL = docURL.appendingPathComponent("CoreDataModel.sqlite")
      do {
        try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        DispatchQueue.main.sync(execute: complectionBlock)
      } catch {
        fatalError("Error migrating store: \(error)")
      }
    }
  }
}

extension CoreDataManager: CoreDataManagerProtocol {
  func findObject<T>(for entity: T.Type, entityName: String, predicate: NSPredicate) -> T? {
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    request.predicate = predicate
    request.fetchLimit = 1
    request.returnsObjectsAsFaults = false
    
    do {
      let results = try managerObjectContext.fetch(request)
      return results.first as? T
    } catch let error as NSError {
      debugPrint("Error while finding object: \(error.localizedDescription)")
    }
    
    return nil
  }
  
  func fetchOne<T>(from entity: String,
                   predict: NSPredicate,
                   success: (T?) -> Void,
                   failure: CompletionBlock) {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    request.predicate = predict
    request.fetchLimit = 1
    
    do {
      guard let results = try managerObjectContext.fetch(request) as? [T] else {
        fatalError("Error generic type: \(T.self)")
      }
      
      if let response = results.first {
        success(response)
      } else {
        success(nil)
        debugPrint("No object response")
      }
    } catch {
      debugPrint("Fetch error \(error)")
      failure?(error)
    }
  }
  
  func save(completion: CompletionBlock) {
    do {
      try managerObjectContext.save()
      debugPrint("Object saved")
      completion?(nil)
    } catch {
      debugPrint("Object save error \(error)")
      completion?(error)
    }
  }
  
  func deleteAll(from entity: String,completion: CompletionBlock) {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    let delete = NSBatchDeleteRequest(fetchRequest: request)
    
    do {
      try managerObjectContext.execute(delete)
      debugPrint("Objects Deleted")
      completion?(nil)
    } catch {
      debugPrint("Object save error \(error)")
      completion?(error)
    }
  }
}

