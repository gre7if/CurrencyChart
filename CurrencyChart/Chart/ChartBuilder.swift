//
//  ChartBuilder.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation

class ChartBuilder {
    
    static func build() -> ChartViewController {
        
        let networkClient = WebSocketClient()
        let mapper = ChartMapper()
        
        let service = ChartService(networkClient: networkClient, mapper: mapper)
        
        let presenter = ChartPresenter(service: service)
                
        let viewController = ChartViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}
