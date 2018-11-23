//
//  Weather+CoreDataProperties.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/23/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var city: String?
    @NSManaged public var desc: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: Int16
    @NSManaged public var temp: Int16

}
