//
//  WeatherRowViewModel.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/23/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import Foundation

struct WeatherRowViewModel {
    let weather: WeatherProtocol
    let iconUrl: String
    let country: String
    let desc: String
    let temperature: String
}

extension WeatherRowViewModel {
    init(_ weather: WeatherProtocol) {
        self.weather = weather
        
        iconUrl = weather.iconUrl
        country = weather.city
        desc = weather.desc
        temperature = weather.tempCelsius
    }
}

extension WeatherRowViewModel: RowViewModel {
    var reusableIdentifier: String {
        return WeatherCell.className
    }
}
