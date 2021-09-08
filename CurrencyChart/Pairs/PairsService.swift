//
//  PairsService.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation

protocol PairsServiceProtocol {
    func updatePairsList(_ completion: @escaping(PairsResponse) -> Void)
}

class PairsService: PairsServiceProtocol {
    
    var networkClient: Network
    var mapper: PairsMapper
    
    init(networkClient: Network, mapper: PairsMapper) {
        self.networkClient = networkClient
        self.mapper = mapper
    }
    
    func updatePairsList(_ completion: @escaping (PairsResponse) -> Void) {
        networkClient.loadData { [unowned self] result in
            switch result {
            case .success(let value):
                guard let mappedData = self.mapper.map(data: value) else { return }
                completion(mappedData)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
