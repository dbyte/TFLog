//
//  LogConfigurationTests.swift
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

class LogConfigurationTests: TFLogTestBase {
    
    // MARK: - Setup/Teardown
    
    var sut: LogConfigurable!
    
    override func setUp() {
        super.setUp()
        sut = LogConfiguration()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests

extension LogConfigurationTests {
    
    final func testInitializationShouldSetExpectedDefaults() {
        
        let config = LogConfiguration()
        
        XCTAssertEqual(config.isLoggingActive, true)
        XCTAssertTrue(
            config.logProvider is OSLogProvider,
            "Expected default type \(OSLogProvider.self) but returned \(config.logProvider)")
        XCTAssertEqual(config.isTimestampIncluded, false)
        XCTAssertEqual(config.subsystemID, "")
        
        let defaultSymbols = LogLevelPrefix()
        
        if config.logLevelPrefix is LogLevelPrefix == false {
            XCTFail("Expected default type \(LogLevelPrefix.self) but returned \(config.logLevelPrefix)")
            return // return early, else code below would stall testing
        }
        
        // swiftlint:disable:next force_cast
        XCTAssertEqual(defaultSymbols, config.logLevelPrefix as! LogLevelPrefix)
    }
    
    final func testActivateLogging() {
        sut.activateLogging(true)
        XCTAssertEqual(sut.getIsLoggingActive(), true)
        sut.activateLogging(false)
        XCTAssertEqual(sut.getIsLoggingActive(), false)
    }
    
    final func testSetLogProvider() {
        var expectedProvider: LogProvider = LogProviderMock()
        sut.setLogProvider(expectedProvider)
        var returnedProvider: LogProvider = sut.getLogProvider()
        XCTAssertTrue(
            expectedProvider is LogProviderMock,
            "Expected default type \(LogProviderMock.self) but returned \(returnedProvider)")
        
        expectedProvider = OSLogProvider()
        sut.setLogProvider(expectedProvider)
        returnedProvider = sut.getLogProvider()
        XCTAssertTrue(
            expectedProvider is OSLogProvider,
            "Expected default type \(OSLogProvider.self) but returned \(returnedProvider)")
        
        expectedProvider = ConsoleLogProvider()
        sut.setLogProvider(expectedProvider)
        returnedProvider = sut.getLogProvider()
        XCTAssertTrue(
            expectedProvider is ConsoleLogProvider,
            "Expected default type \(ConsoleLogProvider.self) but returned \(returnedProvider)")
    }
    
    final func testIncludeTimestamp() {
        sut.includeTimestamp(true)
        XCTAssertEqual(sut.getIsTimestampIncluded(), true)
        sut.includeTimestamp(false)
        XCTAssertEqual(sut.getIsTimestampIncluded(), false)
    }
    
    final func testGetSubsystemID() {
        sut.setSubsystemID("com.dbyte.myApp")
        XCTAssertEqual(sut.getSubsystemID(), "com.dbyte.myApp")
        sut.setSubsystemID("com.someOther.app")
        XCTAssertEqual(sut.getSubsystemID(), "com.someOther.app")
    }
    
    final func testReplaceLogLevelSymbols() {
        let expectedLogLevelSymbols: LogLevelPrefixInterface =
            sut.replaceLogLevelSymbols()
                .setAction("a")
                .setCanceled("b")
                .setError("c")
                .setOther("d")
                .setSuccess("e")
                .setWarning("f")
                .buildAndReplace()
        
        let cachedLogLevelSymbols = sut.getLogLevelSymbols()
        
        if cachedLogLevelSymbols as? LogLevelPrefix == nil {
            XCTFail("Object cachedLogLevelSymbols could not be downcasted to \(LogLevelPrefix.self). " +
                "Expected concrete type for \(LogLevelPrefixInterface.self).")
            return // return early, else code below would stall testing
        }
        
        XCTAssertEqual(cachedLogLevelSymbols as? LogLevelPrefix, expectedLogLevelSymbols as? LogLevelPrefix)
    }
    
    final func testReplaceSymbols() {
        let defaultLogLevelSymbols = sut.getLogLevelSymbols()
        let expectedLogLevelSymbols = sut.replaceLogLevelSymbols()
            .setAction("a")
            .setCanceled("b")
            .setError("c")
            .setOther("d")
            .setSuccess("e")
            .setWarning("f")
            .build()
        
        sut.replaceSymbols(with: expectedLogLevelSymbols)
        
        if expectedLogLevelSymbols as? LogLevelPrefix == nil {
            XCTFail("Object expectedLogLevelSymbols could not be downcasted to \(LogLevelPrefix.self). " +
                "Expected concrete type for \(LogLevelPrefixInterface.self).")
            return // return early, else code below would stall testing
        }
        
        XCTAssertNotEqual(expectedLogLevelSymbols as? LogLevelPrefix, defaultLogLevelSymbols as? LogLevelPrefix)
    }
}
