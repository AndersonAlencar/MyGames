//
//  ViewController+CoreData.swift
//  MyGames
//
//  Created by Anderson Alencar on 18/08/19.
//  Copyright © 2019 Anderson Alencar. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
extension UIViewController {
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context // recuperamos o coreData Stack criado pelo nosso persistente container
    }
}
