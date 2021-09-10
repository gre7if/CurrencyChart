//
//  ChartService.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation

protocol ChartServiceProtocol {
    func updateChart(pair: String, _ completion: @escaping(Ticker) -> Void)
    func stopChartUpdate()
}

class ChartService: ChartServiceProtocol {
    
    private let networkClient: WebSocketProtocol
    private let mapper: ChartMapper
    
    init(networkClient: WebSocketProtocol, mapper: ChartMapper) {
        self.networkClient = networkClient
        self.mapper = mapper
    }
    
    func updateChart(pair: String, _ completion: @escaping (Ticker) -> Void) {
        networkClient.connect()
        
        NotificationCenter.default.addObserver(
            forName: .websocketDidConnect,
            object: nil,
            queue: OperationQueue.main,
            using: { [weak self] notification in
                let msgDic = [
                    "event": "subscribe",
                    "channel": "ticker",
                    "symbol": "t\(pair)"
                ]
                
                do {
                    let msg = try JSONEncoder().encode(msgDic)
                    self?.networkClient.post(message: msg)
                } catch let error {
                    print("Error: \(error)")
                }
            }
        )
        
        NotificationCenter.default.addObserver(
            forName: .websocketDidReceiveMessage,
            object: nil,
            queue: OperationQueue.main,
            using: { [weak self] notification in
                guard let mappedData = self?.mapper.map(data: notification.object) else { return }
                completion(mappedData)
            }
        )
    }
    
    func stopChartUpdate() {
        networkClient.disconnect()
    }
}
