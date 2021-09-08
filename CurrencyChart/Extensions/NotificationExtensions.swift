//
//  NotificationExtensions.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation

extension Notification.Name {
    static let websocketDidConnect = Notification.Name("WebsocketDidConnect")
    static let websocketDidDisconnect = Notification.Name("WebsocketDidDisconnect")
    static let websocketDidReceiveMessage = Notification.Name("WebsocketDidReceiveMessage")
}
