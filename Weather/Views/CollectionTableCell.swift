//
//  CollectionTableCell.swift
//  Weather
//
//  Created by Дарина Самохина on 24.03.2025.
//

import UIKit

class CollectionTableCell: UITableViewCell {

    static let reuseIdentifier = String(describing: CollectionTableCell.self)
    static var nib: UINib {
        return UINib(nibName: String(describing: CollectionTableCell.self), bundle: nil)
    }
    
    @IBOutlet var collectionView: UICollectionView!

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

