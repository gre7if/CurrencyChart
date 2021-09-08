//
//  PairsBuilder.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation

class PairsBuilder {
    
    static func build() -> PairsViewController {
        let viewController = PairsViewController()
    
        let networkClient = NetworkClient()
        let mapper = Mapper()
        
        let service = PairsService()
        service.networkClient = networkClient
        service.mapper = mapper
        
        let presenter = PairsPresenter()
        presenter.service = service
        presenter.view = viewController
        
        let viewModel = PairsViewModel(pairs: nil)
        viewController.output = presenter
        viewController.viewModel = viewModel
        
        return viewController
    }
}
