//
//  Coin.swift
//  CryptoMonitor
//
//  Created by Степан Фоминцев on 09.05.2023.
//

import Foundation

struct CoinData: Decodable {
    let coins: [Coin]
    
    init(coins: [Coin]) {
        self.coins = coins
    }
    
    init(from data: [String: [Any]]) {
        guard let data = data["coins"] as? [[String: Any]] else {
            coins = []
            return
        }
        coins = data.map { Coin(from: $0) }
    }
}

struct Coin: Decodable {
    let id: String
    let icon: String
    let name: String
    let symbol: String
    let rank: Int
    let price: Double
    let volume: Double
    let marketCap: Double
    let priceChange1d: Double
    
    init(id: String, icon: String, name: String, symbol: String, rank: Int, price: Double, volume: Double, marketCap: Double, priceChange1d: Double) {
        self.id = id
        self.icon = icon
        self.name = name
        self.symbol = symbol
        self.rank = rank
        self.price = price
        self.volume = volume
        self.marketCap = marketCap
        self.priceChange1d = priceChange1d
    }
    
    init(from coinData: [String: Any]) {
        id = coinData["id"] as? String ?? ""
        icon = coinData["icon"] as? String ?? ""
        name = coinData["name"] as? String ?? ""
        symbol = coinData["symbol"] as? String ?? ""
        rank = coinData["rank"] as? Int ?? 0
        price = coinData["price"] as? Double ?? 0
        volume = coinData["volume"] as? Double ?? 0
        marketCap = coinData["marketCap"] as? Double ?? 0
        priceChange1d = coinData["priceChange1d"] as? Double ?? 0
    }
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
