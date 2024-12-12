//
//  HomeViewController.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 11/12/24.
//

import Foundation
import UIKit

class SearchViewController: BaseViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    private var tableView: UITableView!
    private var searchBar: UISearchBar!
    private var cancelButton: UIButton!
    private var recentSearches: [String] = []
    private var searchResults: [Track] = []
    private var searchTask: DispatchWorkItem?


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        loadRecentSearches()
        self.currentTabbar(.search)
//        setupCustomBackButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }


    private func setupUI() {
        view.backgroundColor = .black
        
        searchBar = UISearchBar()
        searchBar.placeholder = "Search for songs or artists"
        searchBar.searchTextField.textColor = .white
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .black
        view.addSubview(searchBar)
        self.addFooterView()

        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.tintColor = .white
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelButton)

        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 44),

            cancelButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }

    @objc private func didTapCancel() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchResults = []
        tableView.reloadData()
        navigationController?.popViewController(animated: true)

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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           searchTask?.cancel()
           let task = DispatchWorkItem { [weak self] in
               guard let self = self else { return }
               if !searchText.isEmpty {
                   self.fetchSearchResults(searchTerm: searchText)
               } else {
                   self.searchResults = []
                   self.tableView.reloadData()
               }
           }
           self.searchTask = task
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: task)
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
            let dbHandler = DBHandler()
            dbHandler.insertTrack(
                trackName: selectedTrack.trackName ?? "Unknown",
                artistName: selectedTrack.artistName ?? "Unknown",
                trackURL: selectedTrack.artworkUrl100 ?? ""
            )
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (80)
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
