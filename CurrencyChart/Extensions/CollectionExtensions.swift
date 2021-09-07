//
//  CollectionExtensions.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 21.08.2021.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array {

    func flattenedToArray<ReturnType>() -> [ReturnType] {
        reduce([]) { result, element in
            if let value = element as? ReturnType {
                return result + [value]
            }
            guard let values = element as? [ReturnType] else {
                return result
            }
            return result + values
        }
    }
}
