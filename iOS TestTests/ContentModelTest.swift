//
//  ContentModelTest.swift
//  iOS TestTests
//
//  Created by shereena on 23/12/2022.
//

import Foundation
import XCTest
@testable import iOS_Test
class ArticleModelTestCase: XCTestCase {
    func ContentModelTest_canCreateInstance() {
        
        let instanceStatus = Status(errorCode: 0, totalCount: 20)
        
        let instanceQuote = Quote(usd: Usd(price: 11.0, percentChange1H: 11.0))
        
        let instanceCryptoCurrencies = CryptoCurrencies(id: 1, name: "Bit Coin", symbol: "BIT", quote: instanceQuote)
        
        let instance = ContentModel(status: instanceStatus, data: [instanceCryptoCurrencies])
        
        
        XCTAssertNotNil(instance)
                                    
    }
}
