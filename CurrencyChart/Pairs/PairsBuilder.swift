//
//  PairsBuilder.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation

class PairsBuilder {
    
    static func build() -> PairsViewController {
        
        let networkClient = NetworkClient()
        let mapper = PairsMapper()
        
        let service = PairsService(networkClient: networkClient, mapper: mapper)
        
        let presenter = PairsPresenter(service: service)
                
        let viewController = PairsViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}
