//
//  Data.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/20/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import Foundation

extension Data {
    var json: JSONDictionary? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? JSONDictionary
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
