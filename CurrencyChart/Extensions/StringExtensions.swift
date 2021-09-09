//
//  StringExtensions.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 09.09.2021.
//

import Foundation

extension String {
    func formattedPair() -> String {
        var pair = self
        if let indexOfColon = pair.firstIndex(of: ":") {
            pair.remove(at: indexOfColon)
            pair.insert("/", at: indexOfColon)
        } else {
            pair.insert("/", at: pair.index(pair.startIndex, offsetBy: 3))
        }
        return pair
    }
    
    func formattedPairForRequest() -> String {
        var pair = self
        if let indexOfColon = pair.firstIndex(of: ":") {
            pair.remove(at: indexOfColon)
        }
        return pair
    }
}
