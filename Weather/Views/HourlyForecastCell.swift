//
//  HourlyForecastCell.swift
//  Weather
//
//  Created by Дарина Самохина on 24.03.2025.
//

import UIKit
import Kingfisher

class HourlyForecastCell: UICollectionViewCell {
    
    static let cellIdentifier = String(describing: HourlyForecastCell.self)
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var hourLabel: UILabel = {
        createLabel()
    }()
    
    private lazy var temperatureLabel: UILabel = {
        createLabel()
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        backgroundColor = .white.withAlphaComponent(0.3)
        setSubviews(weatherImageView, hourLabel, temperatureLabel)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with hourForecast: Hour, andLocalHour localHour: String) {
        hourLabel.text = getTime(fromApiDate: hourForecast.time, andLocalHour: localHour)
        temperatureLabel.text = "\(hourForecast.tempC)°"
        fetchImage(from: hourForecast.condition.icon)
    }
}

//MARK: - Private Methods
extension HourlyForecastCell {
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Avenir Heavy", size: 19)
        label.textAlignment = .center
        return label
    }
    
    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            hourLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            hourLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            weatherImageView.widthAnchor.constraint(equalToConstant: 50),
            weatherImageView.heightAnchor.constraint(equalToConstant: 50),
            weatherImageView.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 10),
            weatherImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.widthAnchor.constraint(equalToConstant: 70),
            temperatureLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 10),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    private func getTime(fromApiDate apiDateString: String, andLocalHour localHour: String) -> String {
        guard let date = apiDateString.toDateWithTime else { return "" }
        let hour = date.getHour
        return localHour == hour ? "Now" : hour
    }
}

//MARK: - Networking
extension HourlyForecastCell {
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
