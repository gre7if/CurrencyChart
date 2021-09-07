//
//  Ticker.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 08.09.2021.
//

import Foundation

struct Ticker {
    let channelId: Int
    let bid: Double
    let bidSize: Double
    let ask: Double
    let askSize: Double
    let dailyChange: Double
    let dailyChangePercent: Double
    let lastPrice: Double
    let volume: Double
    let high: Double
    let low: Double
}
