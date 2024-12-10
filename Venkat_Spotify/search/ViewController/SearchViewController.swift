//
//  SearchViewController.swift
//  Venkat_Spotify
//
//  Created by Achu Anil's MacBook Pro on 10/12/24.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    private var tableView: UITableView!
    private var searchBar: UISearchBar!
    private var cancelButton: UIButton!
    private var recentSearches: [String] = []
    private var searchResults: [Track] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadRecentSearches()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground // Dynamic color

        // Search Bar
        searchBar = UISearchBar()
        searchBar.placeholder = "Search for songs or artists"
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)

        // Cancel Button
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelButton)

        // Table View
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // Register for recent searches

        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        view.addSubview(tableView)

        // Constraints
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 44),

            cancelButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func didTapCancel() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchResults = []
        tableView.reloadData()
    }

    private func loadRecentSearches() {
        recentSearches = UserDefaults.standard.stringArray(forKey: "RecentSearches") ?? []
    }

    private func saveRecentSearch(searchTerm: String) {
        if !recentSearches.contains(searchTerm) {
            recentSearches.insert(searchTerm, at: 0)
            if recentSearches.count > 10 { recentSearches.removeLast() }
            UserDefaults.standard.set(recentSearches, forKey: "RecentSearches")
        }
    }

    private func fetchSearchResults(searchTerm: String) {
        fetchiTunesData(searchTerm: searchTerm) { [weak self] results in
            DispatchQueue.main.async {
                self?.searchResults = results
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        saveRecentSearch(searchTerm: searchTerm)
        fetchSearchResults(searchTerm: searchTerm)
        searchBar.resignFirstResponder()
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.isEmpty ? recentSearches.count : searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchResults.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = recentSearches[indexPath.row]
            cell.textLabel?.textColor = .secondaryLabel
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell
            cell.configure(with: searchResults[indexPath.row])
            return cell
        }
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchResults.isEmpty {
            let searchTerm = recentSearches[indexPath.row]
            searchBar.text = searchTerm
            fetchSearchResults(searchTerm: searchTerm)
        } else {
            let selectedTrack = searchResults[indexPath.row]
            print("Selected track: \(selectedTrack.trackName ?? "Unknown")")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (80)
    }
}








class SearchResultCell: UITableViewCell {
    static let identifier = "SearchResultCell"

    private let songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8 // Rounded corners
        return imageView
    }()

    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = .label // Dynamic color
        return label
    }()

    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .secondaryLabel // Dynamic color
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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


struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Track]
}

struct Track: Decodable {
    let trackName: String?
    let artistName: String?
    let collectionName: String?
    let artworkUrl100: String?
}

func fetchiTunesData(searchTerm: String, completion: @escaping ([Track]) -> Void) {
    let baseUrl = "https://itunes.apple.com/search"
    let queryItems = [
        URLQueryItem(name: "term", value: searchTerm),
        URLQueryItem(name: "media", value: "music"),
        URLQueryItem(name: "country", value: "IN")
    ]
    
    var urlComponents = URLComponents(string: baseUrl)!
    urlComponents.queryItems = queryItems
    
    guard let url = urlComponents.url else {
        print("Invalid URL")
        completion([])
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error fetching data: \(error)")
            completion([])
            return
        }
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let searchResult = try decoder.decode(SearchResult.self, from: data)
                completion(searchResult.results)
            } catch {
                print("Error decoding JSON: \(error)")
                completion([])
            }
        }
    }
    task.resume()
}
