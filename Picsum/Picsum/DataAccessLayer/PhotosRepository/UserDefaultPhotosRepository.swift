//
//  UserDefaultPhotosRepository.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import Foundation

final class UserDefaultPhotosRepository {

    func getHistory() -> [PicsumPhoto] {
        if let data = UserDefaults.standard.data(forKey:  UserDefaultsKey.historyOfPhotos.rawValue) {
                let history = try? JSONDecoder().decode([PicsumPhoto].self, from: data)
                return history ?? []
        }
        return []
    }
    
    @discardableResult
    func savehistory(photo: PicsumPhoto) -> [PicsumPhoto] {
        let history = getHistory()
        
        var result = history.filter { savedPhoto -> Bool in
            photo.id != savedPhoto.id
        }
        result.append(photo)
        let data = try? JSONEncoder().encode(result)
        UserDefaults.standard.set(data, forKey: UserDefaultsKey.historyOfPhotos.rawValue)
        return result
    }
    
    func clearHistory() -> [PicsumPhoto] {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.historyOfPhotos.rawValue)
        return []
    }
}

enum UserDefaultsKey: String {
    case historyOfPhotos
}

