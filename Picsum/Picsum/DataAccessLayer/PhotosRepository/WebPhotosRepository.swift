//
//  WebPhotosRepository.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import Foundation

final class WebPhotosRepository: PhotosRepository {
    
    let client: APIClient
    init(client: APIClient = APIClient()) {
        self.client =  client
    }
    
    func photos(with limit: Int, page: Int, completion: @escaping (Result<[PicsumPhoto], PicsumError>) -> Void) {
        if  let path = APILinksFactory.API.list(limit, page).path {
            guard let url = URL(string: path) else {
                completion(.failure(.wrongURL))
                return }
            client.loadData(from: url) { (result: Result<[PicsumPhoto], PicsumError>) in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
