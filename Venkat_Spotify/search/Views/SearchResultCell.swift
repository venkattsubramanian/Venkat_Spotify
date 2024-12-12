//
//  SearchResultCell.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 12/12/24.
//

import Foundation
import UIKit


class SearchResultCell: UITableViewCell {
    static let identifier = "SearchResultCell"

    private let songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()

    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()

    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(songImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 10
        let imageSize: CGFloat = 50

        songImageView.frame = CGRect(x: padding, y: padding, width: imageSize, height: imageSize)
        trackNameLabel.frame = CGRect(x: songImageView.frame.maxX + padding,
                                       y: padding,
                                       width: contentView.frame.width - imageSize - 3 * padding,
                                       height: 20)
        artistNameLabel.frame = CGRect(x: songImageView.frame.maxX + padding,
                                        y: trackNameLabel.frame.maxY + 5,
                                        width: contentView.frame.width - imageSize - 3 * padding,
                                        height: 20)
    }

    func configure(with track: Track) {
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName
        if let imageUrl = URL(string: track.artworkUrl100 ?? "") {
            // Load image asynchronously (you can use libraries like Kingfisher)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        self.songImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
