//
//  PairsPresenter.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation
    
class PairsPresenter: PairsViewControllerOutput {
    
    weak var view: PairsViewControllerInput?
    private var service: PairsService
    
    init(service: PairsService) {
        self.service = service
    }
    
    func prepareData() {
        service.updatePairsList { [weak self] result in
            guard
                let self = self,
                let view = self.view
            else { return }
            view.setupView(viewModel: result.pairs)
            view.stopActivityIndicator()
            view.reloadView()
        }
    }
}
