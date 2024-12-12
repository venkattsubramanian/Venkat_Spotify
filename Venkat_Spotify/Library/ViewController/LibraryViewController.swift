//
//  HomeViewController.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 10/12/24.
//
import UIKit

class LibraryViewController: BaseViewController {
    
    private var isGridView: Bool = true
    private var tracks: [(trackName: String, artistName: String, trackURL: String)] = []
    private var isDescendingOrder = false
    var folderList: [String] = []
    
    private lazy var gridSwap: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "GridSwap") // Replace with your grid icon
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleViewType))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private lazy var sortImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Sort") // Replace with your grid icon
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sortRecentType))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LibraryCell.self, forCellWithReuseIdentifier: LibraryCell.identifier)
        return collectionView
    }()
    
    lazy var homeHeaderView: QTopHomeHeaderView = {
        let view = QTopHomeHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        self.currentTabbar(.librarury)
        setupToggleButton()
        fetchFloders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFloders()
    }
    
    
    private func fetchFloders() {
        let dbHandler = DBHandler()

       folderList = dbHandler.fetchPlaylists()
        collectionView.reloadData()
    }
    
    private func setupUI() {
        view.addSubview(gridSwap)
        view.addSubview(collectionView)
        view.addSubview(homeHeaderView)
        view.addSubview(sortImage)
        setupConstraints()
        self.addFooterView()
    }
    
    private func setupConstraints() {
        collectionView.collectionViewLayout = createGridLayout()

        
        NSLayoutConstraint.activate([
            homeHeaderView.heightAnchor.constraint(equalToConstant: 120),
            homeHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            homeHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            homeHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        // GridSwap button constraints
        NSLayoutConstraint.activate([
            gridSwap.heightAnchor.constraint(equalToConstant: 20),
            gridSwap.widthAnchor.constraint(equalToConstant: 20),
            gridSwap.topAnchor.constraint(equalTo: homeHeaderView.bottomAnchor, constant: 20),
            gridSwap.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            sortImage.heightAnchor.constraint(equalToConstant: 50),
            sortImage.widthAnchor.constraint(equalToConstant: 140),
            sortImage.topAnchor.constraint(equalTo: homeHeaderView.bottomAnchor, constant: 10),
            sortImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        // CollectionView constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: gridSwap.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120)
        ])
    }
    
    private func setupToggleButton() {
            let toggleButton = UIBarButtonItem(title: "Toggle View", style: .plain, target: self, action: #selector(toggleViewType))
            toggleButton.tintColor = .white
            navigationItem.rightBarButtonItem = toggleButton
        }
        
        @objc private func toggleViewType() {
            isGridView.toggle()
            collectionView.collectionViewLayout = isGridView ? createGridLayout() : createListLayout()
            collectionView.reloadData()
        }
    
    @objc private func sortRecentType() {
        isDescendingOrder.toggle()
        if isDescendingOrder {
            folderList.sort(by: >)
        } else {
            folderList.sort(by: <)
        }
        collectionView.reloadData()
    }

    private func createGridLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let itemsPerRow: CGFloat = 2
        let totalSpacing = (itemsPerRow - 1) * spacing
        let itemWidth = (view.frame.width - totalSpacing) / itemsPerRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        return layout
    }
       private func createListLayout() -> UICollectionViewLayout {
           let layout = UICollectionViewFlowLayout()
           layout.itemSize = CGSize(width: view.frame.width - 20, height: 100)
           layout.minimumInteritemSpacing = 0
           layout.minimumLineSpacing = 10
           return layout
       }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return folderList.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCell.identifier, for: indexPath) as! LibraryCell
            let folder = folderList[indexPath.row]
            cell.configure(title: folder, subtitle: "PlayList . 58 songs", isGridView: isGridView)
            return cell
        }
}
