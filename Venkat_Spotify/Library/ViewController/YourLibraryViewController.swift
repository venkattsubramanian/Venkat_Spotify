//
//  YourLibraryViewController.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 11/12/24.
//

import Foundation
import UIKit

class YourLibraryViewController: UIViewController {
    
    private var playlistName: String = ""
    private var tracks: [(trackName: String, artistName: String, trackURL: String)] = [] {
        didSet {
            songCountLabel.text = "\(tracks.count) songs"
        }
    }
    private var searchResults: [Track] = []
    
    lazy var headerview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var addLibrary: UIImageView! = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.image = #imageLiteral(resourceName: "addLibrary")
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.setImage(UIImage(named: "Back"), for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(yourLibraryCell.self, forCellReuseIdentifier: yourLibraryCell.identifier)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let playlistTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = ""
        return label
    }()
    
    private let songCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "0 songs" // Example count
        return label
    }()
    
       init(playlistName: String) {
           self.playlistName = playlistName
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        playlistTitle.text = self.playlistName
        setupUI()
        fetchTracks()
        setupGradientBackground()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addLibraryTapped))
           addLibrary.addGestureRecognizer(tapGesture)
    }
    private func fetchTracks() {
        let dbHandler = DBHandler()
        tracks = dbHandler.fetchTracks()
        tableView.reloadData()
    }
    
    @objc private func addLibraryTapped() {
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func backBtnAction() {
        let libraryVC = LibraryViewController()
        self.navigationController?.pushViewController(libraryVC, animated: true)

    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.18, green: 0.0, blue: 0.41, alpha: 1.0).cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.25)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    private func setupUI() {
        view.addSubview(headerview)
        headerview.addSubview(addLibrary)
        headerview.addSubview(backButton)
        view.addSubview(playlistTitle)
        view.addSubview(songCountLabel)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            
            headerview.heightAnchor.constraint(equalToConstant: 50),
            headerview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            headerview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headerview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            addLibrary.topAnchor.constraint(equalTo: headerview.topAnchor, constant: 10),
            addLibrary.heightAnchor.constraint(equalToConstant: 30),
            addLibrary.widthAnchor.constraint(equalToConstant: 30),
            addLibrary.trailingAnchor.constraint(equalTo: headerview.trailingAnchor, constant: -10),
            
            backButton.topAnchor.constraint(equalTo: headerview.topAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.leadingAnchor.constraint(equalTo: headerview.leadingAnchor, constant: 10),
            
            playlistTitle.topAnchor.constraint(equalTo: headerview.bottomAnchor, constant: 20),
            playlistTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            songCountLabel.topAnchor.constraint(equalTo: playlistTitle.bottomAnchor, constant: 8),
            songCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            tableView.topAnchor.constraint(equalTo: songCountLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension YourLibraryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.isEmpty ? 0 : tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: yourLibraryCell.identifier, for: indexPath) as? yourLibraryCell else {
            fatalError("Unable to dequeue LibraryCell")
        }
        let track = tracks[indexPath.row]
        let imagename = track.trackURL
        cell.configure(title: track.trackName, subtitle: track.artistName, imageName: [imagename], isGridView: false)
        return cell
    }


}
