//
//  DataLoader.swift
//  PicsumTests
//
//  Created by Mohamed Kelany on 02/01/2022.
//

import Foundation

class DataLoader {

     func loadJsonData(file: String) -> Data? {

        if let jsonFilePath = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") {
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)

            if let jsonData = try? Data(contentsOf: jsonFileURL) {
                return jsonData
            }
        }

        return nil
    }
}
