//
//  PairsPresenter.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation
    
class PairsPresenter: PairsViewControllerOutput {
    
    weak var view: PairsViewControllerInput?
    var service: PairsService
    
    init(service: PairsService) {
        self.service = service
    }
    
    func prepareData() {
        service.updatePairsList { [weak self] result in
            guard
                let pairs = result.pairs,
                let self = self,
                let view = self.view
            else { return }
            let viewModel = PairsViewModel(pairs: pairs)
            view.setupView(viewModel: viewModel)
            view.stopActivityIndicator()
            view.reloadView()
        }
    }
}
