//
//  LargeCardCell.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 12/12/24.
//

import Foundation
import UIKit


class LargeCardCell: UICollectionViewCell {
    static let identifier = "LargeCardCell"

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let descriptionLabel = UILabel()

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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 1

        // Configure Subtitle Label
        subtitleLabel.textColor = .lightGray
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.numberOfLines = 1

        // Configure Description Label
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 2

        // StackView for text content
        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, descriptionLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 6
        labelsStackView.alignment = .fill

        // Add subviews
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
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),

            labelsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelsStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Configure Cell
    func configure(with title: String, subtitle: String, description: String, image: UIImage?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        descriptionLabel.text = description
        imageView.image = image
    }
}
