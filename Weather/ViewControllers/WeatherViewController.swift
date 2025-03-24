//
//  WeatherViewController.swift
//  Weather
//
//  Created by Дарина Самохина on 24.03.2025.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var isMyLocation = false
    private var weather: Weather? {
        didSet {
            headerView.configure(with: weather, andLocation: isMyLocation)
            tableView.reloadData()
        }
    }
    
    private lazy var headerView: TableHeaderView = {
        let header = TableHeaderView.loadFromNib()
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer()
        tableView.tableHeaderView = headerView
        fetchWeather(from: "Moscow")
    }


}

//MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

//MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {


}

//MARK: - Networking
extension WeatherViewController {
    private func fetchWeather(from nameLocation: String) {
        NetworkManager.shared.fetchWeather(
            from: "\(Link.weatherApiURL.rawValue)\(nameLocation)"
        ) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.weather = weather
            case .failure(let error):
                print("Error fetchWeather in WeatherViewController: \(error)")
            }
        }
    }
}

