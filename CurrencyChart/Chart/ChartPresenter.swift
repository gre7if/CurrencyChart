//
//  ChartPresenter.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation

class ChartPresenter: ChartViewControllerOutput {
        
    weak var view: ChartViewControllerInput?
    var service: ChartService
    
    private var counter = 0.0
    
    init(service: ChartService) {
        self.service = service
    }
    
    func prepareData(pair: String) {
        service.updateChart(pair: pair) { [weak self] result in
            guard
                let lastPrice = result.lastPrice,
                let self = self,
                let view = self.view
            else { return }
            print("Last price of \(pair): \(lastPrice)")
            self.counter += 1
            let viewModel = ChartViewModel(x: self.counter, y: lastPrice)
            view.setupView(viewModel: viewModel)
        }
    }
    
    func stopUpdatingData() {
        service.stopChartUpdate()
    }
}
