//
//  MockReachability.swift
//  PicsumTests
//
//  Created by Mohamed Kelany on 02/01/2022.
//

import Network
import Foundation
@testable import Picsum

class MockReachability: Reachability {

    let internetConnectionState: NWPath.Status

    override var isConnected: Bool {
        return internetConnectionState == .satisfied
    }

    init(internetConnectionState: NWPath.Status) {
        self.internetConnectionState  = internetConnectionState
        super.init()
    }
}

