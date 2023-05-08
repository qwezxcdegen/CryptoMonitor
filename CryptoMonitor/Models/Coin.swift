//
//  Coin.swift
//  CryptoMonitor
//
//  Created by Степан Фоминцев on 09.05.2023.
//

import Foundation

struct CoinData: Decodable {
    let coins: [Coin]
}

struct Coin: Decodable {
    let id: String
    let icon: URL
    let name: String
    let symbol: String
    let rank: Int
    let price: Double
    let volume: Double
    let marketCap: Double
    let priceChange1d: Double
}

/*
 "coins": [
     {
       "id": "bitcoin",
       "icon": "https://static.coinstats.app/coins/1650455588819.png",
       "name": "Bitcoin",
       "symbol": "BTC",
       "rank": 1,
       "price": 27506.09809526184,
       "priceBtc": 1,
       "volume": 106739158353.1604,
       "marketCap": 532730351189.36847,
       "availableSupply": 19367718,
       "totalSupply": 21000000,
       "priceChange1h": -0.02,
       "priceChange1d": -4.97,
       "priceChange1w": -0.71,
       "websiteUrl": "http://www.bitcoin.org",
       "twitterUrl": "https://twitter.com/bitcoin",
       "exp": [
         "https://blockchair.com/bitcoin/",
         "https://btc.com/",
         "https://btc.tokenview.io/"
       ]
     },
 */
