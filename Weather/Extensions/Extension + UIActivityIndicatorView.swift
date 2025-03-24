//
//  Extension + UIActivityIndicatorView.swift
//  Weather
//
//  Created by Дарина Самохина on 24.03.2025.
//

import UIKit

extension UIActivityIndicatorView {
    static func showActivityIndicator(in view: UIView, style: UIActivityIndicatorView.Style) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.color = .white
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        return activityIndicator
    }
}
