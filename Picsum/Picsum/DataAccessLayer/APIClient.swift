//
//  APIClient.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import Foundation

import Foundation

protocol URLSessionProtocol {
    func loadData(with url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: URLSessionProtocol {
    func loadData(with url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, _, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
}
class APIClient {
    private var session: URLSessionProtocol
    
    init(withSession session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func loadData<T: Decodable>(from url: URL, completion: @escaping (Result<T, PicsumError>) -> Void) {
        session.loadData(with: url) { data, _ in
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
