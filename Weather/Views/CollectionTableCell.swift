//
//  CollectionTableCell.swift
//  Weather
//
//  Created by Дарина Самохина on 24.03.2025.
//

import UIKit

class CollectionTableCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    
    static let reuseIdentifier = String(describing: CollectionTableCell.self)
    static var nib: UINib {
        return UINib(nibName: String(describing: CollectionTableCell.self), bundle: nil)
    }

    var hoursForecast: [Hour]?
    var localHour: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white.withAlphaComponent(0.2)
        collectionView.dataSource = self
        setupCollectionViewLayout()
        collectionView.register(
            HourlyForecastCell.self,
            forCellWithReuseIdentifier: HourlyForecastCell.cellIdentifier
        )
    }
    
    func configure(with weather: Weather) {
        hoursForecast = getTwentyFourHourForecast(in: weather)
        localHour = getLocalHour(in: weather)
    }
}

//MARK: - Private Methods
extension CollectionTableCell {
    private func getLocalHour(in weather: Weather) -> String {
        guard let localTime = weather.location.localTime.toDateWithTime else { return "" }
        let localHour = localTime.getHour
        return localHour
    }
    
    private func getTwentyFourHourForecast(in weather: Weather) -> [Hour] {
        var hoursForecast: [Hour] = []
        let localHour = getLocalHour(in: weather)
        let localHourInt = Int(localHour) ?? 0
        
        for day in 0..<weather.forecast.forecastDay.count - 1 {
            let dayForecast = weather.forecast.forecastDay[day]
            var timestamps = dayForecast.hour
            
            if day == 0 {
                timestamps.removeFirst(localHourInt)
                hoursForecast = timestamps
            } else {
                let residue = 24 - hoursForecast.count
                hoursForecast += timestamps.prefix(residue)
            }
        }
        return hoursForecast
    }
}

//MARK: - UICollectionViewDataSource
extension CollectionTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hoursForecast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HourlyForecastCell.cellIdentifier,
            for: indexPath
        ) as? HourlyForecastCell else { return UICollectionViewCell() }
        guard let hour = hoursForecast?[indexPath.item] else { return UICollectionViewCell() }
        cell.configure(with: hour, andLocalHour: localHour ?? "")
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CollectionTableCell: UICollectionViewDelegateFlowLayout {
    private func setupCollectionViewLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.minimumLineSpacing = 7
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            layout.collectionView?.backgroundColor = .clear
            collectionView.collectionViewLayout = layout
        }
    }
}

