//
//  WeatherListDataManager.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/23/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import Foundation

extension CityObject: WeatherProtocol {
    
    var icon: String {
        return weather.first?.icon ?? ""
    }
    
    var city: String {
        return name + ", " + country
    }
    
    var desc: String {
        guard let desc = weather.first?.desc else {return ""}
        return desc
    }
    
    var temp: Float {
        return main.temp
    }
}

final class WeatherListDataManger {
    
}

extension WeatherListDataManger: WeatherListDataMangerProtocol {
    
    var allCities: [WeatherProtocol] {
        return DataStorage.read(type: CityObject.self)
    }
    
    func createCities(_ json: JSONDictionary) -> [WeatherProtocol] {
        var __json = json
        var list = [JSONDictionary]()
        
        if let items = __json["list"] as? [JSONDictionary] {
            
            for item in items {
                var dict = item
                
                if var weather = (dict["weather"] as? [JSONDictionary])?.first {
                    weather["desc"] = weather["description"]
                    dict["weather"] = [weather]
                }
                
                list.append(dict)
            }
        }
        
        __json["list"] = list
        
//        DataStorage.write(list, type: CityObject.self)
        
        let cities = DataStorage.write( __json, type: CitiesObject.self).list
        return Array(cities)
    }
}
