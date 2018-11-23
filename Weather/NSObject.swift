//
//  NSObject.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/20/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
