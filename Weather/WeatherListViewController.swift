//
//  WeatherListViewController.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/20/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import UIKit

protocol WeatherListViewModelProtocol {
    func loadData()
    func refresh(_ completion: ((UIBackgroundFetchResult) -> Void)?)
}

class WeatherListViewController: UIViewController {

    @IBOutlet private var tableViewTop: NSLayoutConstraint!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var errorLabel: UILabel!
    
    private let refreshControl = UIRefreshControl()
    
    internal var isLoadingData = false {
        didSet {
            isLoadingData ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
        }
    }
    
    var viewModel: WeatherListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.dataSource = viewModel as? UITableViewDataSource
        tableView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToNotifiationCenter(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        subscribeToNotifiationCenter(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.loadData()
    }
    
    @objc private func refresh() {
        viewModel?.refresh(nil)
    }
    
    @IBAction private func didPressRefreshButton() {
        tableView.setContentOffset(CGPoint(x: 0, y: -refreshControl.frame.size.height), animated: true)
        viewModel?.refresh(nil)
    }
}

extension WeatherListViewController: WeatherListViewProtocol {
    
    func reloadData() {
        tableView.reloadData()
    }
}

//MARK: Notification Center

extension WeatherListViewController {
    
    func subscribeToNotifiationCenter(_ subscribed: Bool) {
        let center = NotificationCenter.default
        
        if !subscribed {
            center.removeObserver(self)
        } else {
            center.addObserver(self, selector: #selector(networkConnectionChanged), name: .networkConnectionChanged, object: nil)
        }
    }
    
    @objc private func networkConnectionChanged(_ notif: Notification) {
        guard let reachability = notif.object as? Reachability else {return}
       
        let showError = reachability.status == .unreachable
        
        errorLabel.text = "offlineModel".localized + Date.currentTime
        tableViewTop.constant = showError ? 30 : 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.errorLabel.isVisible = showError
            self.view.layoutIfNeeded()
        }, completion: { complete in
            if !showError {
                self.refresh()
            }
        })
    }
}
