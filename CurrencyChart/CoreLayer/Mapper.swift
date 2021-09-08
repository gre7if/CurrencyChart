//
//  Mapper.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation

protocol MapperProtocol {
    func map(data: Any?) -> PairsResponse?
}

class Mapper: MapperProtocol {
    func map(data: Any?) -> PairsResponse? {
        guard let data = data as? [[String]] else { return nil }
        let dataArray: [String] = data.flatMap { $0 }
        return PairsResponse(pairs: dataArray)
    }
}
