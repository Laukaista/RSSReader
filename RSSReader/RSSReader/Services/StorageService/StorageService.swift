//
//  StorageService.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 3.02.23.
//

import Foundation
import CoreData
import UIKit

final class StorageService: StorageServiceProtocol {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RSSReader")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func createEntity(from models: [NewsModel], completion: @escaping (Bool) -> Void) {
        let context = persistentContainer.viewContext
        for model in models {
            let new = News(context: context)
            
            new.title = model.title
            new.date = Date()
            new.imageLink = model.imageLink?.description
            new.isViewed = model.viewed
            new.content = model.content
            new.newsLink = model.newsLink?.description ?? ""
        }
        
        do {
            try context.save()
        } catch {
            completion(false)
        }
        
        completion(true)
    }
    
    func readEntities(completion: @escaping ([News]) -> Void) {
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        let entities = try? persistentContainer.viewContext.fetch(fetchRequest)

        completion(entities ?? [])
    }
    
    func updateEntity(from model: NewsModel, completion: @escaping (Bool) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title LIKE %@", model.title)
        
        let entity = try? persistentContainer.viewContext.fetch(fetchRequest)
        entity?.first?.isViewed = model.viewed
        
        do {
            try context.save()
        } catch {
            completion(false)
        }
        
        completion(true)
    }
    
    func deleteEntity(with title: String, completion: @escaping (Bool) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title LIKE %@", title)
        
        do {
            guard let entity = try context.fetch(fetchRequest).first
            else {
                completion(false)
                return
            }
            context.delete(entity)
            try context.save()
        } catch {
            completion(false)
        }
        
        completion(true)
    }
}

