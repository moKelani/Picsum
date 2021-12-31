//
//  NotificationName.swift
//  Picsum
//
//  Created by Mohamed Kelany on 31/12/2021.
//

import Foundation

protocol NotificationName {
    var name: Notification.Name { get }
}

extension RawRepresentable where RawValue == String, Self: NotificationName {
    var name: Notification.Name {
        return Notification.Name(rawValue)
    }
}

enum Notifications {
    enum Reachability: String, NotificationName {
        case connected
        case notConnected
    }
}

