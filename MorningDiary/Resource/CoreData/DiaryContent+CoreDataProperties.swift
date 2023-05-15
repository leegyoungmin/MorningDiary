//
//  DiaryContent+CoreDataProperties.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

//

import Foundation
import CoreData


extension DiaryContent {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryContent> {
    return NSFetchRequest<DiaryContent>(entityName: "DiaryContent")
  }
  
  @NSManaged public var body: String
  @NSManaged public var createdDate: String
  @NSManaged public var id: UUID
  @NSManaged public var issuedDate: String
  @NSManaged public var title: String
}

extension DiaryContent : Identifiable {
}
