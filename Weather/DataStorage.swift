//
//  DataStorage.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/23/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import Foundation
import RealmSwift

final class DataStorage {
    static func write<T: Object>(_ json: Any, type: T.Type) -> T {
        var result: T?
        
        do {
            let realm = try Realm()
            try realm.write {
                result = realm.create(type, value: json, update: T.primaryKey() != nil)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return result!
    }
    
    static func read<T: Object>(type: T.Type) -> Array<T> {
        var result: Results<T>!
        
        do {
            let realm = try Realm()
            result = realm.objects(type)
        } catch {
            print(error.localizedDescription)
            return []
        }
        return Array(result)
    }
}
