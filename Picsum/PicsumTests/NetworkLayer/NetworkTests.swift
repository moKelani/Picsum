//
//  NetworkTests.swift
//  PicsumTests
//
//  Created by Mohamed Kelany on 02/01/2022.
//

import XCTest
@testable import Picsum

class NetworkTests: XCTestCase {
    
    func test_GetItems_Success() throws {

        let mockAPIClient =  getMockAPIClient(fromJsonFile: "data")
        loadData(mockAPIClient: mockAPIClient) { (result: Result<[PicsumPhoto], PicsumError>) in
            switch result {
            case .success(let photos):
                guard !photos.isEmpty else {
                    XCTFail("Can't get Data")
                    return
                }
                XCTAssertGreaterThan(photos.count, 0)
            default:
                XCTFail("Can't get Data")
            }
        }
    }
    
    func test_NotGetData_Fail() throws {

        let mockAPIClient =  getMockAPIClient(fromJsonFile: "noData")
        loadData(mockAPIClient: mockAPIClient) { (result: Result<[PicsumPhoto], PicsumError>) in
            switch result {
            case .success(let photos):
                guard photos.isEmpty else {
                    XCTFail("Can't get Data")
                    return
                }
                XCTAssertEqual(photos.count, 0)
            default:
                XCTFail("Can't get Data")
            }
        }
    }
    
    private func getMockAPIClient(fromJsonFile file: String) -> APIClient {
        let mockSession = MockURLSession.createMockSession(fromJsonFile: file, andStatusCode: 200, andError: nil)
        return APIClient(withSession: mockSession)
    }

    private func loadData<T: Decodable>(mockAPIClient: APIClient, completion: @escaping (Result<T, PicsumError>) -> Void) {
        guard let path = APILinksFactory.API.list(5, 1).path, let url = URL(string: path) else {
            return
        }
        mockAPIClient.loadData(from: url, completion: completion)
    }
    
}
