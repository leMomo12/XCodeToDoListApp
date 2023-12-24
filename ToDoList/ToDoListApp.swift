//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Maurice Nowotni on 21.12.23.
//

import SwiftUI

@main
struct ToDoListApp: App {
    @StateObject private var dataController = DataController(name: "ToDoModel")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
