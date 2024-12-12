//
//  SmallGridCell.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 12/12/24.
//

import Foundation
import UIKit

class SmallGridCell: UICollectionViewCell {
    static let identifier = "SmallGridCell"

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .darkGray
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true

        // Configure ImageView
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8

        // Configure Title Label
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center

        // Configure Subtitle Label
        subtitleLabel.textColor = .lightGray
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textAlignment = .center

        // Create StackView for Labels
        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 4
        labelsStackView.alignment = .fill

        // Add Subviews
        contentView.addSubview(imageView)
        contentView.addSubview(labelsStackView)

        // Disable autoresizing mask
        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false

        // Set Constraints
        NSLayoutConstraint.activate([
            // ImageView constraints
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor), // Square aspect ratio

            // Labels StackView constraints
            labelsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            labelsStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Configure Cell
    func configure(with title: String, subtitle: String, image: UIImage?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        imageView.image = image
    }
}
