//
//  StringExtensions.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 09.09.2021.
//

import Foundation

extension String {
    mutating func formattedPair() -> String {
        if let indexOfColon = self.firstIndex(of: ":") {
            self.remove(at: indexOfColon)
            self.insert("/", at: indexOfColon)
        } else {
            self.insert("/", at: self.index(self.startIndex, offsetBy: 3))
        }
        return self
    }
}
