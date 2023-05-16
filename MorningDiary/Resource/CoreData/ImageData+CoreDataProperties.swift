//
//  ImageData+CoreDataProperties.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.
        
//

import Foundation
import CoreData


extension ImageData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageData> {
        return NSFetchRequest<ImageData>(entityName: "ImageData")
    }

    @NSManaged public var data: Data
    @NSManaged public var attachment: NSSet

}

// MARK: Generated accessors for attachment
extension ImageData {

    @objc(addAttachmentObject:)
    @NSManaged public func addToAttachment(_ value: DiaryContent)

    @objc(removeAttachmentObject:)
    @NSManaged public func removeFromAttachment(_ value: DiaryContent)

    @objc(addAttachment:)
    @NSManaged public func addToAttachment(_ values: NSSet)

    @objc(removeAttachment:)
    @NSManaged public func removeFromAttachment(_ values: NSSet)

}

extension ImageData : Identifiable {

}
