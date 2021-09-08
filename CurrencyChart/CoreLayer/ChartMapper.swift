//
//  ChartMapper.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation

protocol ChartMapperProtocol {
    func map(data: Any?) -> Ticker?
}

class ChartMapper: ChartMapperProtocol {
    // parse Any to our Model
    func map(data: Any?) -> Ticker? {
        guard
            let text = data as? String,
            let data = text.data(using: .utf16),
            let jsonData = try? JSONSerialization.jsonObject(with: data),
            let jsonArray = jsonData as? [Any]
        else { return nil }
        
        let currencyPair: [Double] = jsonArray.flattenedToArray()
        
        guard
            let channelId = currencyPair[safe: Ticker.ArrayIndex.channelId.rawValue],
            let bid = currencyPair[safe: Ticker.ArrayIndex.bid.rawValue],
            let bidSize = currencyPair[safe: Ticker.ArrayIndex.bidSize.rawValue],
            let ask = currencyPair[safe: Ticker.ArrayIndex.ask.rawValue],
            let askSize = currencyPair[safe: Ticker.ArrayIndex.askSize.rawValue],
            let dailyChange = currencyPair[safe: Ticker.ArrayIndex.dailyChange.rawValue],
            let dailyChangePercent = currencyPair[safe: Ticker.ArrayIndex.dailyChangePercent.rawValue],
            let lastPrice = currencyPair[safe: Ticker.ArrayIndex.lastPrice.rawValue],
            let volume = currencyPair[safe: Ticker.ArrayIndex.volume.rawValue],
            let high = currencyPair[safe: Ticker.ArrayIndex.high.rawValue],
            let low = currencyPair[safe: Ticker.ArrayIndex.low.rawValue]
        else { return nil }
        
        return Ticker(
            channelId: channelId,
            bid: bid,
            bidSize: bidSize,
            ask: ask,
            askSize: askSize,
            dailyChange: dailyChange,
            dailyChangePercent: dailyChangePercent,
            lastPrice: lastPrice,
            volume: volume,
            high: high,
            low: low
        )
    }
}
