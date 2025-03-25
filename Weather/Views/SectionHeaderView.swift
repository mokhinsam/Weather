//
//  SectionHeaderView.swift
//  Weather
//
//  Created by Дарина Самохина on 25.03.2025.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = String(describing: SectionHeaderView.self)

    private lazy var sectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white.withAlphaComponent(0.5)
        return imageView
    }()
    
    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setSubviews(sectionImageView, sectionTitleLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with section: SectionHeader) {
        sectionImageView.image = UIImage(systemName: section.image.rawValue)
        sectionTitleLabel.text = section.title.rawValue
    }
}

//MARK: - Private Methods
extension SectionHeaderView {
    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            sectionImageView.widthAnchor.constraint(equalToConstant: 20),
            sectionImageView.heightAnchor.constraint(equalToConstant: 20),
            sectionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            sectionImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sectionTitleLabel.leadingAnchor.constraint(equalTo: sectionImageView.trailingAnchor, constant: 5),
            sectionTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
