//
//  PhotosListBuilder.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import UIKit

struct PhotosListBuilder {
    
    static func viewController() -> PhotosListViewController {
        let viewController: PhotosListViewController = PhotosListViewController()
        let router = PhotosListRouter(viewController: viewController)
        let presenter = PhotosListPresenter(output: viewController, router: router)
        
        viewController.presenter = presenter
        return viewController
    }
}
