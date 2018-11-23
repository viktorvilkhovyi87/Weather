//
//  WeatherListViewModel.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/20/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import UIKit

protocol WeatherListCoordinatorProtocol: class {
    func start() -> UIWindow
}

protocol WeatherListDataMangerProtocol {
    var allCities: [WeatherProtocol] {get}
    func createCities(_ json: JSONDictionary) -> [WeatherProtocol]
}

protocol WeatherListViewProtocol: class {
    var isLoadingData: Bool {set get}
    func reloadData()
}

final class WeatherListViewModel: DataSource, WeatherListViewModelProtocol {
    
    weak var view: WeatherListViewProtocol?
    
    var dataManager: WeatherListDataMangerProtocol?
    
    var coordinator: WeatherListCoordinatorProtocol?
    
    var isLoading = false {
        didSet {
            if isLoading {
                DispatchQueue.main.async {
                    self.view?.isLoadingData = true
                }
            } else {
                runAfter(0.5) {
                    self.view?.isLoadingData = false
                }
            }
        }
    }
}

//MARK: DATA FETCHING

extension WeatherListViewModel {
    
    func loadData() {
        if let dataManager = dataManager, !dataManager.allCities.isEmpty {
            viewModels = dataManager.allCities.map{WeatherRowViewModel($0)}
            view?.reloadData()
        } else {
            refresh()
        }
    }
    
    func refresh(_ completion: ((UIBackgroundFetchResult) -> Void)? = nil) {
        isLoading = true
        
        Server.whatIsTheWeatherInCities(ids: "524901,703448,2643743") { [weak self] data, error in guard let this = self else {return}
            if let error = error {
                print(error.localizedDescription)
                completion?(.failed)
            } else if let json = data?.json {
                
                this.parseJSON(json)
                
                completion?(.newData)
            } else {
                completion?(.noData)
            }
            
            this.isLoading = false
        }
    }
    
    private func parseJSON(_ json: JSONDictionary) {
        if let cities = dataManager?.createCities(json) {
            viewModels = cities.map{WeatherRowViewModel($0)}
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        } else {
            refresh()
        }
    }
}

