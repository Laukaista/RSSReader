//
//  News+CoreDataProperties.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 3.02.23.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var title: String
    @NSManaged public var date: Date
    @NSManaged public var imageLink: String?
    @NSManaged public var isViewed: Bool
    @NSManaged public var content: String

}

extension News : Identifiable {

}
