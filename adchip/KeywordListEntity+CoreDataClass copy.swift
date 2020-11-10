//
//  KeywordListEntity+CoreDataClass.swift
//  
//
//  Created by 野中志保 on 2020/09/15.
//
//

import UIKit
import Foundation
import CoreData


public class KeywordListEntity: NSManagedObject {
    
//    override public func awakeFromInsert() {
//        super.awakeFromInsert()
//        keyword = "あどちっぷ"
//        timer1 = Date()
//    }
    
    // create
    func createList(keyword:String, timer1:Date, timer2:Date?, timer3:Date?, timer4:Date?) -> KeywordListEntity {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newList = KeywordListEntity(context: context)
        newList.keyword = keyword
        newList.timer1 = timer1
        newList.timer2 = timer2
        newList.timer3 = timer3
        newList.timer4 = timer4
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        return newList
    }
    
    // reload
    func reloadAllList() -> [KeywordListEntity] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let savedPlaceFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "KeywordListEntity")
        do {
            let result = try context.fetch(savedPlaceFetch)
            if let convertedResult = result as? [KeywordListEntity] {
                return convertedResult
            }
        } catch {
            return []
        }
        return []
    }
    
    // update
    func modifyList(_ entity: KeywordListEntity?) {
        //保存する
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // delete
    func deleteObject(_ object: NSManagedObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.delete(object)
        //保存する
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
