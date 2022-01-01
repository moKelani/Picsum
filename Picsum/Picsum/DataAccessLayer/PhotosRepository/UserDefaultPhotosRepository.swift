//
//  UserDefaultPhotosRepository.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import Foundation

final class UserDefaultPhotosRepository: PhotosRepository {
    
    func photos(with limit: Int, page: Int, completion: @escaping (Result<[PicsumPhoto], PicsumError>) -> Void) {
        
    }
    
    func getHistory() -> [PicsumPhoto] {
        if let history = UserDefaults.standard.array(forKey: UserDefaultsKey.historyOfPhotos.rawValue) as? [PicsumPhoto] {
            return history
        }
        return []
        
    }
    
    @discardableResult
    func savehistory() -> [PicsumPhoto] {
        let history = getHistory()
        UserDefaults.standard.set(history, forKey: UserDefaultsKey.historyOfPhotos.rawValue)
        return history
    }
    
    func clearHistory() -> [PicsumPhoto] {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.historyOfPhotos.rawValue)
        return []
    }
}

enum UserDefaultsKey: String {
    case historyOfPhotos
}

