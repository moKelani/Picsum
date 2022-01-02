//
//  APIClient.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import Foundation

// MARK: - DataTask
protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

protocol URLSessionProtocol {
    @discardableResult func loadData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    @discardableResult func loadData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let task = dataTask(with: url) { (data, response, error) in
            completionHandler(data, response, error)
        }
        task.resume()
        
        
        return task
    }
}
class APIClient {
    private var session: URLSessionProtocol
    
    init(withSession session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func loadData<T: Decodable>(from url: URL, completion: @escaping (Result<T, PicsumError>) -> Void) {
        session.loadData(with: url) { data, _, _ in
            do {
                guard let data = data else {
                    completion(.failure(.noResults))
                    return
                }

                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))

            } catch let error {
                completion(.failure(.runtimeError(error.localizedDescription)))

            }
        }
    }
}
