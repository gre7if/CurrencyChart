//
//  WebSocketClient.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Starscream

protocol WebSocketProtocol {
    func connect()
    func post(message: Data)
    func disconnect()
}

class WebSocketClient: WebSocketProtocol {
    
    let urlString = "wss://api-pub.bitfinex.com/ws/2"
    var socket: WebSocket?
    
    func connect() {
        var request = URLRequest(url: URL(string: urlString)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    func post(message: Data) {
        socket?.write(data: message)
    }
    
    func disconnect() {
        print("\nWebsocket is disconnected")
        socket?.disconnect()
        socket?.delegate = nil
    }
}

extension WebSocketClient: WebSocketDelegate {
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        
        switch event {
        case .connected:
            print("\nWebsocket is connected")
            NotificationCenter.default.post(name: .websocketDidConnect, object: self)
            
        case .disconnected(let reason, let code):
            print("\nWebsocket is disconnected: \(reason) with code: \(code)")
            
        case .text(let text):
            NotificationCenter.default.post(name: .websocketDidReceiveMessage, object: text)
            
        case .binary(let data):
            print("\nReceived data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            break
        case .error(let error):
            handleError(error)
        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
}
