//
//  Console+CoreDataProperties.swift
//  MyGames
//
//  Created by Anderson Alencar on 22/10/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//
//

import Foundation
import CoreData


extension Console {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Console> {
        return NSFetchRequest<Console>(entityName: "Console")
    }

    @NSManaged public var name: String?
    @NSManaged public var game: NSSet?

}

// MARK: Generated accessors for game
extension Console {

    @objc(addGameObject:)
    @NSManaged public func addToGame(_ value: Game)

    @objc(removeGameObject:)
    @NSManaged public func removeFromGame(_ value: Game)

    @objc(addGame:)
    @NSManaged public func addToGame(_ values: NSSet)

    @objc(removeGame:)
    @NSManaged public func removeFromGame(_ values: NSSet)

}
