//
//  LogLevelTest.swift
//  TFLogTests
//
//  Created by Tammo on 19.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import XCTest
@testable import TFLog

class LogLevelTest: XCTestCase {
    
    // MARK: - Setup/Teardown
    
    var sut: LogLevel!
    
    override func setUp() {
        super.setUp()
        sut = LogLevel(rawValue: "")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests

extension LogLevelTest {
    
    func testGetSymbol() {
        let config = LogConfigurationStub().withActivatedLoggingAndProviderMock()
        
        let customLogLevelSymbols = LogLevelSymbolBuilder(forConfiguration: config)
            .setAction("a")
            .setCanceled("b")
            .setError("c")
            .setOther("d")
            .setSuccess("e")
            .setWarning("f")
            .build()
        
        XCTAssertEqual(LogLevel.action.getSymbol(from: customLogLevelSymbols), "a")
        XCTAssertEqual(LogLevel.canceled.getSymbol(from: customLogLevelSymbols), "b")
        XCTAssertEqual(LogLevel.error.getSymbol(from: customLogLevelSymbols), "c")
        XCTAssertEqual(LogLevel.other.getSymbol(from: customLogLevelSymbols), "d")
        XCTAssertEqual(LogLevel.success.getSymbol(from: customLogLevelSymbols), "e")
        XCTAssertEqual(LogLevel.warning.getSymbol(from: customLogLevelSymbols), "f")
    }
}
