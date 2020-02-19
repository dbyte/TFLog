//
//  FoundationExtensionsTest.swift
//  TFLogTests
//
//  Created by Tammo on 19.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//
import XCTest
import Foundation
@testable import TFLog

class DateExtensionTest: XCTestCase {
    
    // MARK: - Setup/Teardown
    
    var sut: Date!
    
    override func setUp() {
        super.setUp()
        sut = Date()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests

extension DateExtensionTest {
    
    func testConvertToTimezoneISO8601() {
        let expectedResult = "2025-02-19T18:54:32+01:00"
        let sut = Date()
        let formatOptions: ISO8601DateFormatter.Options =
            [.withYear,
             .withMonth,
             .withDay,
             .withFullTime,
             .withDashSeparatorInDate,
             .withColonSeparatorInTime]
        let stringResult = sut.convertToTimezoneISO8601(timeZone: TimeZone.current, formatOptions: formatOptions)
        
        XCTAssertEqual(stringResult, expectedResult)
    }
}
