//
//  NetworkClient.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 06.09.2021.
//

import Alamofire

protocol Network {
    func loadData(completion: @escaping(Result<Any, AFError>) -> Void)
}

class NetworkClient: Network {
    
    let urlString = "https://api-pub.bitfinex.com/v2/conf/pub:list:pair:exchange"
    
    func loadData(completion: @escaping(Result<Any, AFError>) -> Void) {
        AF.request(urlString)
            .validate()
            .responseJSON { response in
                completion(response.result)
            }
    }
}

