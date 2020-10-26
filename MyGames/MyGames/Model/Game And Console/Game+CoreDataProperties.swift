//
//  Game+CoreDataProperties.swift
//  MyGames
//
//  Created by Anderson Alencar on 22/10/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var cover: NSObject?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var console: Console?

}
