//
//  PairsViewModel.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation

struct PairsViewModel {
    
    private let pairs: [String]?
    
    init(pairs: [String]?) {
        self.pairs = pairs
    }
    
    func numberOfItems() -> Int {
        guard let pairs = pairs else { return 0 }
        return pairs.count
    }
    
    func getItem(index: Int) -> String? {
        guard let pairs = pairs else { return "" }
        return pairs[safe: index]
    }
    
    func getItems() -> [String] {
        guard let pairs = pairs else { return [] }
        return pairs
    }
}
