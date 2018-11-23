//
//  WeatherObject.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/23/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import Foundation
import RealmSwift

class CitiesObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var cnt = 0
    
    let list = List<CityObject>() 
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class CityObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var country = ""
    @objc dynamic var main: CityMainObject!
    
    let weather = List<WeatherObject>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class CityMainObject: Object {
    @objc dynamic var temp: Float = 0.0
}

class WeatherObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var desc = ""
    @objc dynamic var icon = ""
    
}
