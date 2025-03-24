//
//  Extension + UIImage.swift
//  Weather
//
//  Created by Дарина Самохина on 24.03.2025.
//

import UIKit

extension UIImage {
    static func showPlaceholderImage() -> UIImage {
        let image = UIImage(
            systemName: "thermometer.medium",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 100,
                weight: .light,
                scale: .small
            )
        )
        return image ?? UIImage()
    }
}
