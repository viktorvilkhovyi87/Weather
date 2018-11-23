//
//  DataSource.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/20/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import UIKit

protocol RowViewModel {
    var reusableIdentifier: String {get}
}

class DataSource: NSObject {
    var viewModels = [RowViewModel]()
}

extension DataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count.bitValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reusableIdentifier, for: indexPath)
        (cell as? Configurable)?.configure(viewModel)
        return cell
    }
}
