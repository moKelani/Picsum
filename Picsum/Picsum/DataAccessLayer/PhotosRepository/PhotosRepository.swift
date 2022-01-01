//
//  PhotosRepository.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import Foundation

protocol PhotosRepository {
    func photos(with limit: Int, page: Int, completion: @escaping (Result<[PicsumPhoto], PicsumError>) -> Void)
}

