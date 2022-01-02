//
//  PhotosListViewControllerTests.swift
//  PicsumTests
//
//  Created by Mohamed Kelany on 02/01/2022.
//

import Foundation
import XCTest
@testable import Picsum

class PhotosListViewControllerTests: XCTestCase {
    var photosListViewController: PhotosListViewController!

    override func setUp() {
        super.setUp()
        photosListViewController =  PhotosListBuilder.viewController()
        // Arrange: setup UINavigationController
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.rootViewController = UINavigationController(rootViewController: photosListViewController)
    }

    override func tearDown() {
        photosListViewController = nil
    }

    func test_getData_success() {
        let mockSession = MockURLSession.createMockSession(fromJsonFile: "data", andStatusCode: 200, andError: nil)
        let repository = getMockWebPhotosRepository(mockSession: mockSession)
        let router = PhotosListRouter(viewController: photosListViewController)
        let presenter = PhotosListPresenter(output: photosListViewController, router: router, photosRepository: repository)
        photosListViewController.presenter = presenter
        presenter.getPhotoList()
        XCTAssertNotNil(photosListViewController.collectionDataSource)
        XCTAssertNotNil(photosListViewController.collectionDataSource?.presenterInput)
        XCTAssertEqual(photosListViewController.collectionDataSource?.itemsForCollection.count, 11)
    }

    func getMockWebPhotosRepository(mockSession: MockURLSession) -> WebPhotosRepository {
        let mockAPIClient =  APIClient(withSession: mockSession)
        return WebPhotosRepository(client: mockAPIClient)
    }
}

