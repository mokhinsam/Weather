//
//  Extension + NSLayoutConstraint.swift
//  Weather
//
//  Created by Дарина Самохина on 24.03.2025.
//

import UIKit

extension NSLayoutConstraint {
    func setPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
