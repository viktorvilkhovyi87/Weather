//
//  UIView.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/20/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import UIKit

extension UIView {
    var isVisible: Bool {
        set { alpha = newValue ? 1 : 0}
        get { return alpha == 1}
    }
}
