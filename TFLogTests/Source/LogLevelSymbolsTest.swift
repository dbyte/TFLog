//
//  LogLevelSymbolsTest.swift
//  TFLogTests
//
//  Created by Tammo on 19.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import XCTest
@testable import TFLog

class LogLevelSymbolsTest: XCTestCase {
    
    // MARK: - Setup/Teardown
    
    var sut: LogLevelSymbolsInterface!
    
    override func setUp() {
        super.setUp()
        sut = LogLevelSymbols()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests

extension LogLevelSymbolsTest {
    
    func testInitializationShouldSetExpectedDefaults() {
        sut = LogLevelSymbols()
        
        XCTAssertEqual(sut.action, "📘")
        XCTAssertEqual(sut.canceled, "📓")
        XCTAssertEqual(sut.error, "📕")
        XCTAssertEqual(sut.other, "📔")
        XCTAssertEqual(sut.success, "📗")
        XCTAssertEqual(sut.warning, "📙")
    }
}
