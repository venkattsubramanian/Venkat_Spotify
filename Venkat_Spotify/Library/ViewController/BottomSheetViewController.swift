//
//  HomeViewController.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 10/12/24.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    lazy var playlistImage: UIImageView! = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = #imageLiteral(resourceName: "playlist")
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let playlistLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "Playlist"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.isUserInteractionEnabled = true // Enable interaction
        return label
    }()

    
    private let createPlaylist: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Create PlayList with a Song"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        setConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playlistLabelTapped))
        backView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func playlistLabelTapped() {
        let addPlaylistVC = AddPlaylistViewController() // Replace with your new VC
        addPlaylistVC.modalPresentationStyle = .overFullScreen // Optional style
        present(addPlaylistVC, animated: true)
    }
    
    func setConstraints() {
        view.addSubview(playlistImage)
        view.addSubview(backView)
        backView.addSubview(playlistLable)
        backView.addSubview(createPlaylist)


        
        NSLayoutConstraint.activate([

            playlistImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            playlistImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            playlistImage.widthAnchor.constraint(equalToConstant: 60),
            playlistImage.heightAnchor.constraint(equalToConstant: 60),
            
            
            backView.leadingAnchor.constraint(equalTo: playlistImage.trailingAnchor, constant: 10),
            backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            backView.heightAnchor.constraint(equalToConstant: 80),
            
            
            playlistLable.leadingAnchor.constraint(equalTo: playlistImage.trailingAnchor, constant: 10),
            playlistLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),

            createPlaylist.leadingAnchor.constraint(equalTo: playlistImage.trailingAnchor, constant: 10),
            createPlaylist.topAnchor.constraint(equalTo: playlistLable.bottomAnchor, constant: 10),
        ])
    }
    

}
