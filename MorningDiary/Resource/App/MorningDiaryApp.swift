//
//  MorningDiaryApp.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.


import SwiftUI

@main
struct MorningDiaryApp: App {
  let persistenceController = PersistentController.shared
  var body: some Scene {
    WindowGroup {
      DiaryBoardView()
        .environment(\.managedObjectContext, persistenceController.container
          .viewContext)
    }
  }
}
