//
//  APi.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/20/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import Foundation

final class Server {
    static private let appId = "a1d1dc41d71e2b1c1d329e64770bf088"
    static private let api = "https://api.openweathermap.org/data/2.5/"
    
    static private var parameters: [String: String] {
        return ["appid": appId, "units": "metric"]
    }
    
    static private func get(urlString: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void) {
        var components = URLComponents(string: urlString)
        var items = [URLQueryItem]()
        
        params.forEach { key, value in
            items.append(URLQueryItem(name: key, value: value))
        }
        
        components?.queryItems = items
        
        guard let url = components?.url else {return}
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, error)
        }.resume()
    }
    
    static func whatIsTheWeatherIn(_ city: String, completion: @escaping (Data?, Error?) -> Void) {
        var params = parameters
        params["q"] = city
        get(urlString: api + "weather", params: params, completion: completion)
    }
    
    static func whatIsTheWeatherInCities(ids: String, completion: @escaping (Data?, Error?) -> Void) {
        var params = parameters
        params["id"] = ids
        get(urlString: api + "group", params: params, completion: completion)
    }
}
