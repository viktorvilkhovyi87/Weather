//
//  WeatherListCoordinator.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/21/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import UIKit

final class WeatherListCoordinator: WeatherListCoordinatorProtocol {
    
    private var reachability: Reachability!
    
    private var rootViewController: WeatherListViewController!
    
    func start() -> UIWindow {
        
        do {
            reachability = try Reachability(hostname: "www.apple.com")
            try reachability.start()
        } catch {
            print(error.localizedDescription)
        }
        
        let viewModel = WeatherListViewModel()
        viewModel.dataManager = WeatherListDataManger()
        
        let viewController = from(WeatherListViewController.self)
        viewController.viewModel = viewModel
        
        viewModel.view = viewController
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        rootViewController = viewController
        
        return window
    }
    
    func fetchWeatherInfoInBackground(completion: @escaping (UIBackgroundFetchResult) -> Void) {
        rootViewController.viewModel?.refresh(completion)
    }
}
