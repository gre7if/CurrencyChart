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
                guard let data = response.value else { return }
                
                let dataArray = Array(arrayLiteral: data)
                let stringArray = dataArray.flattenedToStringArray()
                completion(stringArray)
            }
    }
}

