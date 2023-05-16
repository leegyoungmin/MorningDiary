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
    @NSManaged public var imageData: NSSet

}

// MARK: Generated accessors for imageData
extension DiaryContent {

    @objc(addImageDataObject:)
    @NSManaged public func addToImageData(_ value: ImageData)

    @objc(removeImageDataObject:)
    @NSManaged public func removeFromImageData(_ value: ImageData)

    @objc(addImageData:)
    @NSManaged public func addToImageData(_ values: NSSet)

    @objc(removeImageData:)
    @NSManaged public func removeFromImageData(_ values: NSSet)

}

extension DiaryContent : Identifiable {

}
