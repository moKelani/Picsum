//
//  UIImageView+DownloadImage.swift
//  Picsum
//
//  Created by Mohamed Kelany on 31/12/2021.
//

import Kingfisher

extension UIImageView {
    func setImage(path: String){
        self.kf.setImage(with: URL(string: path), placeholder: nil, options: nil, progressBlock: nil) { _ in }
    }
}
