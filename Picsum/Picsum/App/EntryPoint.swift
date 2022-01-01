//
//  EntryPoint.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import UIKit

struct EntryPoint {
    
    func initPhotoListScreen(window: UIWindow) {
        window.rootViewController = UINavigationController(rootViewController: PhotosListBuilder.viewController())
        window.makeKeyAndVisible()
    }
    
}
