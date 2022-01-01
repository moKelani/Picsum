//
//  APILinksFactory.swift
//  Picsum
//
//  Created by Mohamed Kelany on 01/01/2022.
//

import Foundation

struct APILinksFactory {

    private static let baseURL = "https://picsum.photos/v2/"

    enum API {
        case list(_ limit: Int,_ page: Int)

        var path: String? {
            switch self {
            case .list(let limit, let page):
                return APILinksFactory.baseURL + "list?page=\(page)&limit=\(limit)"
            }
        }
    }
}
