//
//  CityMock.swift
//  WeatherTests
//
//  Created by Viktor Vilkhovyi on 11/21/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import Foundation

struct CitiesMock: Decodable {
    var cnt: Int
    let list: Array<CityMock>
    
    enum CodingKeys: String, CodingKey {
        case list, cnt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cnt = try container.decode(Int.self, forKey: .cnt)
        list = try container.decode(Array<CityMock>.self, forKey: .list)
    }
}

struct CityMock: Decodable {
    let id: Int
    let name: String
    let main: WeatherMainMock
    let weather: [WeatherMock]
    
    enum CodingKeys: String, CodingKey {
        case id, main, weather, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        weather = try container.decode(Array<WeatherMock>.self, forKey: .weather)
        main = try container.decode(WeatherMainMock.self, forKey: .main)
    }
}

struct WeatherMock: Decodable {
    let id: Int
    let desc: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, description, icon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        desc = try container.decode(String.self, forKey: .description)
        icon = try container.decode(String.self, forKey: .icon)
    }
}

struct WeatherMainMock: Decodable {
    let temp: Int
}
