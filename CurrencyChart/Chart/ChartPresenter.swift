//
//  ChartPresenter.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation

class ChartPresenter: ChartViewControllerOutput {
        
    weak var view: ChartViewControllerInput?
    private var service: ChartService
    
    private var counter = 0.0
    
    init(service: ChartService) {
        self.service = service
    }
    
    func prepareData(pair: String) {
        service.updateChart(pair: pair) { [weak self] result in
            guard
                let self = self,
                let view = self.view
            else { return }
            print("Last price of \(pair): \(result.lastPrice)")
            self.counter += 1
            let viewModel = PointViewModel(x: self.counter, y: result.lastPrice)
            view.setupView(viewModel: viewModel)
        }
    }
    
    func stopUpdatingData() {
        service.stopChartUpdate()
    }
}
