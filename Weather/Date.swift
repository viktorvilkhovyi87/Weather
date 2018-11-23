//
//  Date.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/23/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import Foundation

extension Date {
    static var currentTime: String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return "\(hour):\(minutes)"
    }
}
