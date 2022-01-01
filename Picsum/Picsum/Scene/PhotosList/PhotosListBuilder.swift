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
        let presenter = PhotosListPresenter(output: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
