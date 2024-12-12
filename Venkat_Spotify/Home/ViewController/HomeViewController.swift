//
//  HomeViewController.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 10/12/24.
//

import UIKit

class HomeViewController: BaseViewController {

    // Define collection view
    private var collectionView: UICollectionView!
    
    private let homeHead: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Good Morning"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()

    private let podcastlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Podcasts & Show"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.borderWidth = 0.5
        label.borderColor = .white
        label.layer.cornerRadius = .ratioWidthBasedOniPhoneX(15)
        return label
    }()
    private let musicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Playlist"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.borderWidth = 0.5
        label.borderColor = .white
        label.layer.cornerRadius = .ratioWidthBasedOniPhoneX(15)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureUI()
    }

    // Set up the collection view
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0: // Horizontal scrolling section (Good afternoon)
                return self.createHorizontalScrollingSection()
            case 1: // Large card (Picked for you)
                return self.createLargeCardSection()
            case 2: // Horizontal scrolling (Jump back in)
                return self.createHorizontalScrollingSection()
            default:
                return nil
            }
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self

        // Register cell types
        collectionView.register(SmallGridCell.self, forCellWithReuseIdentifier: SmallGridCell.identifier)
        collectionView.register(LargeCardCell.self, forCellWithReuseIdentifier: LargeCardCell.identifier)

        view.addSubview(collectionView)
        view.addSubview(homeHead)
        view.addSubview(musicLabel)
        view.addSubview(podcastlabel)

        // Constraints
        NSLayoutConstraint.activate([
            homeHead.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            homeHead.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            homeHead.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            musicLabel.topAnchor.constraint(equalTo: homeHead.bottomAnchor, constant: 20),
            musicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            musicLabel.heightAnchor.constraint(equalToConstant: 30),
            musicLabel.widthAnchor.constraint(equalToConstant: 80),
            
            podcastlabel.topAnchor.constraint(equalTo: homeHead.bottomAnchor, constant: 20),
            podcastlabel.leadingAnchor.constraint(equalTo: musicLabel.trailingAnchor, constant: 10),
            podcastlabel.heightAnchor.constraint(equalToConstant: 30),
            podcastlabel.widthAnchor.constraint(equalToConstant: 150),

            
            collectionView.topAnchor.constraint(equalTo: musicLabel.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    // Configure UI
    private func configureUI() {
        view.backgroundColor = .black
        self.addFooterView()
        self.currentTabbar(.home)
    }

    private func createHorizontalScrollingSection() -> NSCollectionLayoutSection {
        // Define item size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .absolute(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Add spacing (insets) around each item
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        // Define group size and layout
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        // Create the section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 5 // Space between groups
        section.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 10, bottom: 8, trailing: 10)

        return section
    }


    private func createLargeCardSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 16, bottom: 8, trailing: 16)
        return section
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3 // Good afternoon, Picked for you, Jump back in
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 6 // Number of horizontal items
        case 1: return 1 // Single large card
        case 2: return 6 // Number of horizontal items
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0, 2: // Horizontal scrolling sections
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallGridCell.identifier, for: indexPath) as! SmallGridCell
            cell.configure(with: "Title \(indexPath.row)", subtitle: "Subtitle", image: UIImage(named: "pic1"))
            return cell
        case 1: // Large card section
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeCardCell.identifier, for: indexPath) as! LargeCardCell
            cell.configure(
                with: "Science VS",
                subtitle: "Podcast . Episode 120",
                description: "What the science says about how to bounce back after a few too many.",
                image: UIImage(named: "pic1")
            )
            return cell
        default:
            fatalError("Invalid section")
        }
    }
}

