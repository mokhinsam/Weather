//
//  Extension + UINavigationController.swift
//  Weather
//
//  Created by Дарина Самохина on 25.03.2025.
//

import UIKit

extension UINavigationController {
    func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.shadowColor = .white.withAlphaComponent(0.5)
        self.navigationBar.standardAppearance = navBarAppearance
        self.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationBar.tintColor = .white
    }
}
