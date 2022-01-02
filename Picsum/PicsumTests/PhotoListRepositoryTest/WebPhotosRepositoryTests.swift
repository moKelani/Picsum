//
//  WebPhotosRepositoryTests.swift
//  PicsumTests
//
//  Created by Mohamed Kelany on 02/01/2022.
//

import XCTest
@testable import Picsum

class WebPhotosRepositoryTests: XCTestCase {
    var webPhotosRepository: WebPhotosRepository!
    
    override func setUp() {
        // Arrange: setup ViewModel
        webPhotosRepository = WebPhotosRepository()
    }

    override func tearDown() {
        webPhotosRepository = nil
    }
    
    func test_GetItems_FromAPI() {
        let expectation = XCTestExpectation()

        let mockSession = MockURLSession.createMockSession(fromJsonFile: "data", andStatusCode: 200, andError: nil)
        let mockAPIClient =  APIClient(withSession: mockSession)
        webPhotosRepository = WebPhotosRepository(client: mockAPIClient)
        // Act: get data from API .
        webPhotosRepository.photos(with: 10, page: 1) { (result) in
            switch result {
            case .success(let photos):
                guard  !photos.isEmpty else {
                    return
                }
                // Assert: Verify it's have a data.
                XCTAssertGreaterThan(photos.count, 0)
                XCTAssertEqual(photos.count, 10)
                expectation.fulfill()
            default:
                XCTFail("Can't get Data")
            }

        }
        wait(for: [expectation], timeout: 2)
    }

    func test_NoResult_FromAPI() {
        let expectation = XCTestExpectation()

        let mockSession = MockURLSession.createMockSession(fromJsonFile: "noData", andStatusCode: 200, andError: nil)
        let mockAPIClient =  APIClient(withSession: mockSession)
        webPhotosRepository = WebPhotosRepository(client: mockAPIClient)
        // Act: get data from API .
        webPhotosRepository.photos(with: 5, page: 300) { (result) in
            switch result {
            case .success(let photos):
                guard photos.isEmpty else {
                    return
                }
                // Assert: Verify it's have a data.
                XCTAssertEqual(photos.count, 0)
                expectation.fulfill()
            default:
                XCTFail("Can't get Data")
            }

        }
        wait(for: [expectation], timeout: 2)
    }

}
