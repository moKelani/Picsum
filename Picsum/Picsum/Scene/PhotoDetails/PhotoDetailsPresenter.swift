//
//  PhotoDetailsPresenter.swift
//  Picsum
//
//  Created by Mohamed Kelany on 02/01/2022.
//

import Foundation

protocol PhotoDetailsPresenterInput: BasePresenterInput {
    func updatePhotoDetails()
}

protocol PhotoDetailsPresenterOutput: BasePresenterOutput {
    func updateData(error: Error)
    func updateData(photo: PicsumPhoto)
}

class PhotoDetailsPresenter {
    
    // MARK: Injections
    private weak var output: PhotoDetailsPresenterOutput?
    
    var photo: PicsumPhoto
    // MARK: LifeCycle
    init(output: PhotoDetailsPresenterOutput, photo: PicsumPhoto) {
        self.output = output
        self.photo = photo
        [Notifications.Reachability.connected.name, Notifications.Reachability.notConnected.name].forEach { (notification) in
            NotificationCenter.default.addObserver(self, selector: #selector(changeInternetConnection), name: notification, object: nil)
        }
    }
    
}

// MARK: - PhotosListPresenterInput
extension PhotoDetailsPresenter: PhotoDetailsPresenterInput {
    func updatePhotoDetails() {
        output?.updateData(photo: photo)
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
    
   

}


