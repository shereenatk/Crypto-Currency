//
//  ContentModel.swift
//  iOS Test
//
//  Created by shereena on 23/12/2022.
//

import Foundation

// MARK: - ContentModel
struct ContentModel: Codable, Equatable {
    let status: Status?
    let data: [CryptoCurrencies]
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
    
    static func == (lhs: ContentModel, rhs: ContentModel) -> Bool {
        return  lhs.data.count  ==  rhs.data.count
    }
}
// MARK: - CryptoCurrencies
struct CryptoCurrencies: Codable, Hashable {
    
    static func == (lhs: CryptoCurrencies, rhs: CryptoCurrencies) -> Bool {
        return  lhs.id  ==  rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id )
    }
    
    let id: Int
    let name, symbol: String
    let quote: Quote
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol
        case quote
    }
}

// MARK: - Quote
struct Quote: Codable {
    let usd: Usd
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - Usd
struct Usd: Codable {
    let price, percentChange1H: Double
    
    enum CodingKeys: String, CodingKey {
        case price
        case percentChange1H = "percent_change_1h"
    }
}

// MARK: - Status
struct Status: Codable {
    let errorCode: Int
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case totalCount = "total_count"
    }
}
