//
//  PhotoListRepositoryTest.swift
//  PicsumTests
//
//  Created by Mohamed Kelany on 02/01/2022.
//

import Foundation
@testable import Picsum

class PhotoListRepositoryTest {
    
    let client: APIClient
    init(client: APIClient = APIClient()) {
        self.client =  client
    }
    
    func testPhotoList( url: URL,completion: @escaping (Result<[PicsumPhoto], PicsumError>) -> Void) {
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

