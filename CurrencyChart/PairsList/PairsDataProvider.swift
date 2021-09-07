//
//  PairsDataProvider.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 06.09.2021.
//

import Foundation
import Alamofire

class PairsDataProvider {
    
    private let urlString = "https://api-pub.bitfinex.com/v2/conf/pub:list:pair:exchange"
    
    func fetchPairsList(completion: @escaping([String]) -> Void) {
        AF.request(urlString)
            .validate()
            .responseJSON { response in
                guard let data = response.value as? [[String]] else { return }
                let dataArray: [String] = data.flatMap { $0 }
                completion(dataArray)
            }
    }
}

