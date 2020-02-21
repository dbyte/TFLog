//
//  LogLevelTests.swift
//  TFLogTests
//
//  Copyright (c) 2020 dbyte, Tammo Fornalik.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest
@testable import TFLog

class LogLevelTests: TFLogTestBase {
    
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

extension LogLevelTests {
    
    final func testGetPrefix() {
        let config = LogConfigurationStub().withActivatedLoggingAndProviderMock()
        
        let customLogLevelPrefix = LogLevelPrefixBuilder(forConfiguration: config)
            .setAction("a")
            .setCanceled("b")
            .setError("c")
            .setOther("d")
            .setSuccess("e")
            .setWarning("f")
            .build()
        
        XCTAssertEqual(LogLevel.action.getPrefix(from: customLogLevelPrefix), "a")
        XCTAssertEqual(LogLevel.canceled.getPrefix(from: customLogLevelPrefix), "b")
        XCTAssertEqual(LogLevel.error.getPrefix(from: customLogLevelPrefix), "c")
        XCTAssertEqual(LogLevel.other.getPrefix(from: customLogLevelPrefix), "d")
        XCTAssertEqual(LogLevel.success.getPrefix(from: customLogLevelPrefix), "e")
        XCTAssertEqual(LogLevel.warning.getPrefix(from: customLogLevelPrefix), "f")
    }
}
