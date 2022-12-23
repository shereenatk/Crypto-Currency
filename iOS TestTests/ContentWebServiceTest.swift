//
//  ContentWebServiceTest.swift
//  iOS TestTests
//
//  Created by shereena on 23/12/2022.
//

import Foundation
import XCTest
@testable import iOS_Test

class ContentWebServiceTest: XCTestCase {
    let webService = ContentWebService()
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParameterToApi() {
        let key =  AppConstants.apiKey
        
        XCTAssertEqual(webService.apiKey, key)
    }
    
    func testRequestToApi() {
        
        ContentViewModel().getCurrencyDetails(start: 1, end: 4)
        
        XCTAssertEqual(ContentViewModel().listDetails.status?.errorCode ?? 0, 0)
        
    }
}
