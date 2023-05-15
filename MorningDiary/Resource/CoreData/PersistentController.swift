//
//  PersistentController.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import CoreData

struct PersistentController {
  static let shared = PersistentController()
  
  let container: NSPersistentContainer
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Diary")
    container.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Unresolved Error \(error)")
      }
    }
  }
}

extension PersistentController {
  func saveContext() {
    let context = container.viewContext
    
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let error = error as NSError
        debugPrint(error.localizedDescription)
      }
    }
  }
}
