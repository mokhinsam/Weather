//
//  TableHeaderView.swift
//  Weather
//
//  Created by Дарина Самохина on 24.03.2025.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {

    static var nib: UINib {
        UINib(nibName: String(describing: TableHeaderView.self), bundle: nil)
    }
    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var subLocationLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var weatherDescription: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame.size.width = UIScreen.main.bounds.width
        let fittingSize = CGSize(width: bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let targetSize = systemLayoutSizeFitting(fittingSize)
        if frame.size.height != targetSize.height {
            frame.size.height = targetSize.height
        }
    }
    
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
           fatalError(
             "The nib \(nib) expected its root view to be of type \(self)"
           )
        }
        return view
      }
    
    func configure(with weather: Weather?, andLocation isMyLocation: Bool) {
        locationLabel.text = isMyLocation ? "My Location" : weather?.location.name
        subLocationLabel.text = isMyLocation ? weather?.location.name : weather?.location.country
        temperatureLabel.text = "\(weather?.current.tempC ?? 0)°"
        feelsLikeLabel.text = "Feels like: \(weather?.current.feelsLikeC ?? 0)°"
        weatherDescription.text = weather?.current.condition.text
    }
}

