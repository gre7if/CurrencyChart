//
//  ChartViewController.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 06.09.2021.
//

import UIKit
import Charts
import Starscream

class ChartViewController: UIViewController {
    
    var pair = String()
    private lazy var contentView = ChartView()
    private var counter = 0.0

    private let urlString = "wss://api-pub.bitfinex.com/ws/2"
    private lazy var socket: WebSocket = {
        var request = URLRequest(url: URL(string: urlString)!)
        request.timeoutInterval = 5
        let socket = WebSocket(request: request)
        return socket
    }()
    
    deinit {
        socket.disconnect()
        socket.delegate = nil
    }
    
    private func configureUI() {
        title = pair
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .white
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        socket.disconnect()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        socket.delegate = self
        socket.connect()
    }
    
    private func sendMessageToWebSocket() {
        let msgDic = [
            "event": "subscribe",
            "channel": "ticker",
            "symbol": "t\(pair)"
        ]

        do {
            let msg = try JSONEncoder().encode(msgDic)
            socket.write(data: msg)
        } catch let error {
            print("Error: \(error)")
        }
    }
}

extension ChartViewController: WebSocketDelegate {
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        
        switch event {
        case .connected:
            print("\nWebsocket is connected")
            sendMessageToWebSocket()
            
        case .disconnected(let reason, let code):
            print("\nWebsocket is disconnected: \(reason) with code: \(code)")
            
        case .text(let text):
            guard
                let data = text.data(using: .utf16),
                let jsonData = try? JSONSerialization.jsonObject(with: data),
                let jsonArray = jsonData as? [Any]
            else {
                return
            }
            let currencyPair: [Double] = jsonArray.flattenedToArray()
            guard let lastPrice = currencyPair[safe: 7] else { return }
            print("Last price of \(pair): \(lastPrice)")
            counter += 1
            // line chart
            let entry = ChartDataEntry(x: counter, y: lastPrice)
            contentView.update(entry: entry)
            
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

