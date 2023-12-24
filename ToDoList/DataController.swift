//
//  DataController.swift
//  ToDoList
//
//  Created by Maurice Nowotni on 23.12.23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    var container: NSPersistentContainer
    
    init(name: String) {
        container = NSPersistentContainer(name: name)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Data Core Error: \(error)")
            }
        }
    }
}
