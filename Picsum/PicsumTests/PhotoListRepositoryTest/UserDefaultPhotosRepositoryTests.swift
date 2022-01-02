//
//  UserDefaultHistoryRepositoryTests.swift
//  PicsumTests
//
//  Created by Mohamed Kelany on 02/01/2022.
//

import XCTest
@testable import Picsum

class UserDefaultPhotosRepositoryTests: XCTestCase {
    var historyRepository: UserDefaultPhotosRepository!
    
    override func setUp() {
        historyRepository = UserDefaultPhotosRepository()
        _ = historyRepository.clearHistory()
    }
    
    func testGetItemsFromAPI() {
        // Act: add phhotos tto userDefaults .
        let photo = PicsumPhoto(id: "0", author: "Alejandro Escamilla", width: 5616, height: 3744, url: "https://unsplash.com/photos/yC-Yzbqy7PY", download_url: "https://picsum.photos/id/0/5616/3744")
        historyRepository.savehistory(photo: photo)
        let historyPhhotos = historyRepository.getHistory()
        // Assert: Verify it's have a data.
        XCTAssertEqual(historyPhhotos.count, 1)
        
    }
}

