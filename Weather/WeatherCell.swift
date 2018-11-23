//
//  WeatherItemCell.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/20/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet private var icon: ImageView!
    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!
}

extension WeatherCell: Configurable {
    
    func configure(_ viewModel: Any?) {
        guard let viewModel = viewModel as? WeatherRowViewModel else {
            return
        }
 
        icon.load(viewModel.iconUrl)
        cityLabel.text = viewModel.country
        descriptionLabel.text = viewModel.desc
        temperatureLabel.text = viewModel.temperature
    }
    
}
