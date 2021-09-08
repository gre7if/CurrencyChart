//
//  PairsPresenter.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation
    
class PairsPresenter: PairsViewControllerOutput {
    
    weak var view: PairsViewControllerInput!
    var service: PairsService!
    
    func prepareData() {
        service.updatePairsList { [weak self] result in
            guard let pairs = result.pairs else { return }
            let viewModel = PairsViewModel(pairs: pairs)
            self?.view.setupView(viewModel: viewModel)
            self?.view.stopActivityIndicator()
            self?.view.reloadView()
        }
    }
}
