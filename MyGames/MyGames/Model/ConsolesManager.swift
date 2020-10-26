//
//  ConsolesManager.swift
//  MyGames
//
//  Created by Anderson Alencar on 21/08/19.
//  Copyright © 2019 Anderson Alencar. All rights reserved.
//

import Foundation
import CoreData

class ConsolesManager {
    static let shared = ConsolesManager()
    var consoles: [Console] = []
    private init() {
    }
    
    func loadConsoles(with context: NSManagedObjectContext) {
        let fetchRequest : NSFetchRequest<Console> = Console.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            try consoles = context.fetch(fetchRequest)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func deleteConsole(index: Int, context: NSManagedObjectContext) {
        
        let console = consoles[index]
        context.delete(console)
        do{
            try context.save()
            consoles.remove(at: index)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
}
