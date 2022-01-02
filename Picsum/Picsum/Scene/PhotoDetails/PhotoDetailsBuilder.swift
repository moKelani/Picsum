//
//  PhotoDetailsBuilder.swift
//  Picsum
//
//  Created by Mohamed Kelany on 02/01/2022.
//

import UIKit

struct PhotoDetailsBuilder {
    
    static func viewController(photo: PicsumPhoto) -> PhotoDetailsViewController {
        let viewController: PhotoDetailsViewController = PhotoDetailsViewController()
        let presenter = PhotoDetailsPresenter(output: viewController, photo: photo)
        viewController.presenter = presenter
        return viewController
    }
}

