//
//  PhotosCollectionViewDataSource.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import UIKit

class PhotosCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var itemsForCollection: [ItemCollectionViewCellType?] = []
    
    weak var presenterInput: PhotosListPresenterInput?
    
    private struct CellHeightConstant {
        static let heightOfAdPlaceHolderCell: CGFloat = 120
    }
    
    init(presenterInput: PhotosListPresenterInput?, itemsForCollection: [ItemCollectionViewCellType?]) {
        self.itemsForCollection = itemsForCollection
        self.presenterInput = presenterInput
    }
    
    // MARK: - Collection view data source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !itemsForCollection.isEmpty else {
            return 1
        }
        return itemsForCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = itemsForCollection[indexPath.row]
        switch item {
        case .photo(let photo):
            if let cell: PhotoCollectionCell = collectionView.dequeueReusableCell(for: indexPath) {
                cell.configCell(photo: photo)
                return cell
            }
        case .adPlaceHolder:
            if let cell: AdPlaceHolderCollectionCell = collectionView.dequeueReusableCell(for: indexPath) {
                return cell
            }
        case .none:
            return UICollectionViewCell()

        }
        return UICollectionViewCell()

    }

    
    
    private func getPhotoCellSize(collectionView: UICollectionView) -> CGSize {
        let height = collectionView.bounds.width / 2
        return CGSize(width: collectionView.bounds.width-32, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = itemsForCollection[indexPath.row] {
            switch item {
            case .photo(photo: let photo):
                presenterInput?.navigateToPhotoDetails(photo: photo)
            case .adPlaceHolder:
                break
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if case .adPlaceHolder = itemsForCollection[indexPath.row], indexPath.row == itemsForCollection.count - 1 {
            let pageToGet = Int(indexPath.row / Constant.pageSize) + 1
            presenterInput?.loadMoreData(pageToGet)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let item = itemsForCollection[indexPath.row] {
            switch item {
            case .photo:
                return getPhotoCellSize(collectionView: collectionView)
            case .adPlaceHolder:
                return CGSize(width: collectionView.bounds.width-32, height: CellHeightConstant.heightOfAdPlaceHolderCell)
            }
        } else {
            return getPhotoCellSize(collectionView: collectionView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

}

