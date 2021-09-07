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
    
    func flattenedToStringArray() -> [String] {
        var myArray = [String]()
        for element in self {
            if let element = element as? String {
                myArray.append(element)
            }
            if let element = element as? [Any] {
                let result = element.flattenedToStringArray()
                for i in result {
                    myArray.append(i)
                }
            }
        }
        return myArray
    }

    func flattenedToDoubleArray() -> [Double] {
        var myArray = [Double]()
        for element in self {
            if let element = element as? Double {
                myArray.append(element)
            }
            if let element = element as? [Any] {
                let result = element.flattenedToDoubleArray()
                for i in result {
                    myArray.append(i)
                }
            }
        }
        return myArray
    }
}
