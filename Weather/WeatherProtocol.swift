//
//  Weather.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/20/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import Foundation

protocol WeatherProtocol {
    var icon: String {get}
    var city: String {get}
    var desc: String {get}
    var temp: Float {get}
}

extension WeatherProtocol {
    var iconUrl: String {
        return "http://openweathermap.org/img/w/\(icon).png"
    }
    
    var tempCelsius: String {
        return "\(temp)\u{00B0}"
    }
}
