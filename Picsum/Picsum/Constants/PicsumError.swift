//
//  PicsumError.swift
//  Picsum
//
//  Created by Mohamed Kelany on 31/12/2021.
//

import Foundation

enum PicsumError: Error {
    case failedConnection
    case wrongURL
    case noResults
    case noInternetConnection
    case runtimeError(String)
    case parseError
    case fileNotFound

    var localizedDescription: String {
        switch self {
        case .noResults:
            return "No result found"
        case .noInternetConnection:
            return "No Internet Connection"
        default:
            return "something wrong Happen, please try other time"
        }
    }
}

