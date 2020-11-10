//
//  KeywordListEntity+CoreDataProperties.swift
//  
//
//  Created by 野中志保 on 2020/09/15.
//
//

import Foundation
import CoreData


extension KeywordListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KeywordListEntity> {
        return NSFetchRequest<KeywordListEntity>(entityName: "KeywordListEntity")
    }

    @NSManaged public var keyword: String
    @NSManaged public var timer1: Date
    @NSManaged public var timer2: Date?
    @NSManaged public var timer3: Date?
    @NSManaged public var timer4: Date?
    
    

}
