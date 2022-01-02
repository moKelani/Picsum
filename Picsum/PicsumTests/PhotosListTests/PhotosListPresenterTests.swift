//
//  PhotosListPresenterTests.swift
//  PicsumTests
//
//  Created by Mohamed Kelany on 02/01/2022.
//

import XCTest
@testable import Picsum

class PhotosListPresenterTests: XCTestCase {
    var mockPhotosListPresenterOutput: MockPhotosListPresenterOutput!

    override func setUp() {
        mockPhotosListPresenterOutput = MockPhotosListPresenterOutput()
    }

    override func tearDown() {
        mockPhotosListPresenterOutput = nil
        Reachability.shared =  MockReachability(internetConnectionState: .satisfied)
    }

    func test_getData_success() {
        let presenter = getPhotosListPresenter(fromJsonFile: "data")
        presenter.getPhotoList()
        XCTAssertEqual(mockPhotosListPresenterOutput.itemsForCollection.count, 11)
    }

    func test_loadMore_success() {
        let presenter = getPhotosListPresenter(fromJsonFile: "data")
        presenter.getPhotoList()
        presenter.loadMoreData(2)
        XCTAssertEqual(mockPhotosListPresenterOutput.itemsForCollection.count, 22)
    }


    private func getMockWebPhotosRepository(mockSession: MockURLSession) -> WebPhotosRepository {
        let mockAPIClient =  APIClient(withSession: mockSession)
        return WebPhotosRepository(client: mockAPIClient)
    }

    private func getPhotosListPresenter(fromJsonFile file: String) -> PhotosListPresenter {
        let mockSession = MockURLSession.createMockSession(fromJsonFile: file, andStatusCode: 200, andError: nil)
        let repository = getMockWebPhotosRepository(mockSession: mockSession)
        let router = PhotosListRouter(viewController: UIViewController())
        return PhotosListPresenter(output: mockPhotosListPresenterOutput, router: router, photosRepository: repository)
    }
}

class MockPhotosListPresenterOutput: UIViewController, PhotosListPresenterOutput {
    var itemsForCollection: [ItemCollectionViewCellType] = []
    var error: Error!

    func updateData(error: Error) {
        self.error = error
    }

    func updateData(itemsForCollection: [ItemCollectionViewCellType]) {
        self.itemsForCollection = itemsForCollection
    }
}

