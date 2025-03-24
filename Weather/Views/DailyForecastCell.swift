//
//  DailyForecastCell.swift
//  Weather
//
//  Created by Дарина Самохина on 24.03.2025.
//

import UIKit
import Kingfisher

class DailyForecastCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: DailyForecastCell.self)
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var weekdayLabel: UILabel = {
        createLabel()
    }()
    
    private lazy var lowTemperatureLabel: UILabel = {
        createLabel()
    }()
    
    private lazy var highTemperatureLabel: UILabel = {
        createLabel()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white.withAlphaComponent(0.2)
        setSubviews(
            weatherImageView,
            weekdayLabel,
            highTemperatureLabel,
            lowTemperatureLabel
        )
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with forecastDay: ForecastDay) {
        weekdayLabel.text = getWeekday(from: forecastDay.date)
        lowTemperatureLabel.text = "↓\(forecastDay.day.minTempC)°"
        highTemperatureLabel.text = "↑\(forecastDay.day.maxTempC)°"
        fetchImage(from: forecastDay.day.condition.icon)
    }
}

//MARK: - Private Methods
extension DailyForecastCell {
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Avenir Heavy", size: 19)
        return label
    }
    
    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weekdayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weekdayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weekdayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            weatherImageView.widthAnchor.constraint(equalToConstant: 50),
            weatherImageView.heightAnchor.constraint(equalToConstant: 50),
            weatherImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            lowTemperatureLabel.widthAnchor.constraint(equalToConstant: 75),
            lowTemperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            lowTemperatureLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 10),
            lowTemperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            highTemperatureLabel.widthAnchor.constraint(equalToConstant: 75),
            highTemperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            highTemperatureLabel.leadingAnchor.constraint(equalTo: lowTemperatureLabel.trailingAnchor, constant: 3),
            highTemperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            highTemperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    private func getWeekday(from apiDateString: String) -> String {
        guard let date = apiDateString.toDate else { return "" }
        let currentDate = Date().toString
        return currentDate == apiDateString ? "Today" : date.getWeekday
    }
}

//MARK: - Networking
extension DailyForecastCell {
    private func fetchImage(from url: String) {
        guard let imageURL = URL(string: "https:\(url)") else { return }
        let processor = DownsamplingImageProcessor(size: weatherImageView.bounds.size)
        weatherImageView.kf.indicatorType = .activity
        weatherImageView.kf.setImage(
            with: imageURL,
            placeholder: UIImage.showPlaceholderImage(),
            options: [
                .processor(processor),
                .cacheOriginalImage
            ]
        )
    }
}
