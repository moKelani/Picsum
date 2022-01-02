//
//  PhotosListPresenter.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import Foundation

protocol PhotosListPresenterInput: BasePresenterInput {
    func getPhotoList()
    func loadMoreData(_ page: Int)
    func getHistory()
    func navigateToPhotoDetails(photo: PicsumPhoto)
    var state: State { get set }
}

protocol PhotosListPresenterOutput: BasePresenterOutput {
    func updateData(error: Error)
    func updateData(itemsForCollection: [ItemCollectionViewCellType])
}

enum State {
    case history
    case list
}

class PhotosListPresenter {
    
    // MARK: Injections
    private weak var output: PhotosListPresenterOutput?
    let photosRepository: WebPhotosRepository
    var router: PhotosListRoutable
    
    var state: State = .history

    fileprivate var page: Int = 1
    fileprivate var canLoadMore = true
    // internal
    private var itemsForCollection: [ItemCollectionViewCellType] = [ItemCollectionViewCellType]()
    
    // MARK: LifeCycle
    init(output: PhotosListPresenterOutput, router: PhotosListRoutable,  photosRepository: WebPhotosRepository = WebPhotosRepository()) {
        self.output = output
        self.router = router
        self.photosRepository = photosRepository
        [Notifications.Reachability.connected.name, Notifications.Reachability.notConnected.name].forEach { (notification) in
            NotificationCenter.default.addObserver(self, selector: #selector(changeInternetConnection), name: notification, object: nil)
        }
    }
    
}

// MARK: - PhotosListPresenterInput
extension PhotosListPresenter: PhotosListPresenterInput {
    func navigateToPhotoDetails(photo: PicsumPhoto) {
        router.gotoPhotoDetails(photo: photo)
    }
   
    func getPhotoList() {
        getData()
    }
    
    
    func loadMoreData(_ page: Int) {
        if self.page <= page && canLoadMore == true {
            self.page = page
            if case .list = state {
                getData()
            }
        }
    }
    
    func getHistory() {
        state = .history
        let userDefaultSearchHistoryRepository = UserDefaultPhotosRepository()
        let localPhotos = userDefaultSearchHistoryRepository.getHistory()
        output?.updateData(itemsForCollection: createItemsForCollection(photosArray: localPhotos))
    }

    @objc
    private func changeInternetConnection(notification: Notification) {
        if notification.name == Notifications.Reachability.notConnected.name {
            output?.showError(error: PicsumError.noInternetConnection)
        }
    }
}

// MARK: Setup

extension PhotosListPresenter {
    
    private func getData() {
        self.state = .list
        
        guard Reachability.shared.isConnected else {
            self.output?.updateData(error: PicsumError.noInternetConnection)
            return
        }
        output?.showLoading()
        canLoadMore = false
        
        photosRepository.photos(with: 5, page: page) { [weak self] result in
            
            guard let self =  self else {
                return
            }
            self.output?.hideLoading()
            self.canLoadMore = true
            
            switch result {
            case .success(let photos):
                
                guard !photos.isEmpty  else {
                    self.handleNoPhotos()
                    return
                }
                self.handleNewPhotos(photos: photos)
            case .failure(let error):
                self.output?.updateData(error: error)
            }
        }
    }
    
    private func handleNewPhotos(photos: [PicsumPhoto]) {
        let newItems: [ItemCollectionViewCellType] = createItemsForCollection(photosArray: photos)
        itemsForCollection.append(contentsOf: newItems)
        if itemsForCollection.isEmpty {
            output?.updateData(error: PicsumError.noResults)
        } else {
            output?.updateData(itemsForCollection: itemsForCollection)
        }
    }
    
    private func handleNoPhotos() {
        if  itemsForCollection.isEmpty {
            output?.updateData(error: PicsumError.noResults)
        }
    }

    private func createItemsForCollection(photosArray: [PicsumPhoto]) -> [ItemCollectionViewCellType] {
        var photosList =  photosArray.map { photo -> ItemCollectionViewCellType  in
                .photo(photo: photo)
        }
        
        photosList.append(.adPlaceHolder)
        
        return photosList
    }

}

