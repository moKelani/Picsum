//
//  PhotosListRouter.swift
//  Picsum
//
//  Created by Mohamed Kelany on 02/01/2022.
//

import UIKit

protocol PhotosListRoutable {
    func gotoPhotoDetails(photo: PicsumPhoto)
}

class PhotosListRouter {
    
    // MARK: Injections
    weak var viewController: UIViewController?
    
    // MARK: LifeCycle
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}

// MARK: - PhotosListRoutable
extension PhotosListRouter: PhotosListRoutable {
    func gotoPhotoDetails(photo: PicsumPhoto) {
        viewController?.navigationController?.pushViewController(PhotoDetailsBuilder.viewController(photo: photo), animated: true)
    }
    
    
}

