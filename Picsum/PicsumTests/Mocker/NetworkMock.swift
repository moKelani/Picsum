//
//  NetworkMock.swift
//  PicsumTests
//
//  Created by Mohamed Kelany on 02/01/2022.
//

import UIKit
@testable import Picsum

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    func resume() {}
}

class MockURLSession: URLSessionProtocol {
    func loadData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(self.completionHandler.0,
                          self.completionHandler.1,
                          self.completionHandler.2)
        return dataTask
    }
    
    
    var dataTask = MockURLSessionDataTask()

    var completionHandler: (Data?, URLResponse?, Error?)

    init(completionHandler: (Data?, URLResponse?, Error?)) {
        self.completionHandler = completionHandler
    }
    
    static func createMockSession(fromJsonFile file: String,
                                  andStatusCode code: Int,
                                  andError error: Error?) -> MockURLSession {

        let data = DataLoader().loadJsonData(file: file)

        let response = HTTPURLResponse(url: URL(string: "https://picsum.photos/v2/list?page=1&limit=10")!, statusCode: code, httpVersion: nil, headerFields: nil)

        return MockURLSession(completionHandler: (data, response, error))
    }
}
