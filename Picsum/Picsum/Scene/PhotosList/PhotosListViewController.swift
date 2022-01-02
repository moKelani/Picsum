//
//  PhotosListViewController.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import UIKit

class PhotosListViewController: UIViewController {

    private(set) var collectionDataSource: PhotosCollectionViewDataSource?
    
    // MARK: Outlets
    private let photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 90, height: 90)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.identifier)
        collectionView.register(AdPlaceHolderCollectionCell.self, forCellWithReuseIdentifier: AdPlaceHolderCollectionCell.identifier)
        collectionView.tag = 1
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    
    var presenter: PhotosListPresenterInput?
    
    // MARK: View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationBar()
        getPhotoList()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(photosCollectionView)
        NSLayoutConstraint.activate([
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Picsum"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.basicYellow]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.basicYellow]
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()

        navigationController?.navigationBar.tintColor = UIColor.basicYellow
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance


    }
}

// MARK: UISearch Delegates

extension PhotosListViewController {
    func getPhotoList() {
        presenter?.getPhotoList()
    }

//    func getHistory() {
//        presenter?.getHistory()
//    }
    
    func clearCollection() {
        DispatchQueue.main.async {
            self.collectionDataSource = nil
            self.photosCollectionView.dataSource = nil
            self.photosCollectionView.dataSource = nil
            self.photosCollectionView.reloadData()
        }
    }

    private func emptyState(emptyPlaceHolderType: EmptyPlaceHolderType) {
        clearCollection()
        photosCollectionView.setEmptyView(emptyPlaceHolderType: emptyPlaceHolderType, completionBlock: nil)
    }
}

// MARK: - PhotosListPresenterOutput
extension PhotosListViewController: PhotosListPresenterOutput {

    func updateData(error: Error) {
        switch error as? PicsumError {
        case .noResults:
            self.emptyState(emptyPlaceHolderType: .noResults)
        default:
            self.emptyState(emptyPlaceHolderType: .error(message: error.localizedDescription))
        }
    }

    func updateData(itemsForCollection: [ItemCollectionViewCellType] ) {
        guard !itemsForCollection.isEmpty else {
            return
        }
        
        if collectionDataSource == nil {
            collectionDataSource = PhotosCollectionViewDataSource(presenterInput: presenter, itemsForCollection: itemsForCollection)
        } else {
            collectionDataSource?.itemsForCollection = itemsForCollection
        }

        DispatchQueue.main.async {
            self.photosCollectionView.restore()
            self.photosCollectionView.dataSource = self.collectionDataSource
            self.photosCollectionView.delegate = self.collectionDataSource
            self.photosCollectionView.reloadData()
        }
        
    }
}
