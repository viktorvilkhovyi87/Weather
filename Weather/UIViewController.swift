//
//  UIViewController.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/20/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import UIKit

func from<T>(_ type: T.Type) -> T where T: UIViewController {
    let initialViewController = UIStoryboard(name: type.className, bundle: nil).instantiateInitialViewController()
    return initialViewController as! T
}
