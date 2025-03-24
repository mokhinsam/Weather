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
            stopLoading()
        }
    }
    
    private lazy var headerView: TableHeaderView = {
        let header = TableHeaderView.loadFromNib()
        return header
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView.showActivityIndicator(
            in: view,
            style: .large
        )
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer()
        tableView.tableHeaderView = headerView
        startLoading()
        fetchWeather(from: "Moscow")
    }


}

//MARK: - Private Methods
extension WeatherViewController {
    private func startLoading() {
        tableView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    private func stopLoading() {
        UIView.animate(withDuration: 0.3) {
            self.tableView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
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
                self?.showAlert(withTitle: "Something went wrong with Internet")
                print("Error fetchWeather in WeatherViewController: \(error)")
            }
        }
    }
}

//MARK: - UIAlertController
extension WeatherViewController {
    private func showAlert(withTitle title: String) {
        let alert = UIAlertController(
            title: title,
            message: "Please, check your settings or internet connection and try again",
            preferredStyle: .alert
        )
        let openSettingsAction = UIAlertAction(title: "Open Settings", style: .default) { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url)
        }
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(openSettingsAction)
        alert.addAction(okAction)
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.present(alert, animated: true)
        }
    }
}

