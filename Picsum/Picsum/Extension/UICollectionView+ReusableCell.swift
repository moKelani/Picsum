//
//  UICollectionView+ReusableCell.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import UIKit

extension UICollectionView {

    func dequeueReusableCell<T: CellReusable>(for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T
    }
}

