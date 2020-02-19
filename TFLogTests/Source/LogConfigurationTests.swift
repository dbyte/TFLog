//
//  LogConfigurationTests.swift
//  TFLogTests
//
//  Created by Tammo on 18.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import XCTest
@testable import TFLog

class LogConfigurationTests: XCTestCase {
    
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
    
    func testInitializationShouldSetExpectedDefaults() {
        
        let config = LogConfiguration()
        
        XCTAssertEqual(config.isLoggingActive, true)
        XCTAssertTrue(
            config.logProvider is OSLogProvider,
            "Expected default type \(OSLogProvider.self) but returned \(config.logProvider)")
        XCTAssertEqual(config.isTimestampIncluded, false)
        XCTAssertEqual(config.subsystemID, "")
        
        let defaultSymbols = LogLevelSymbols()
        
        if config.logLevelSymbols is LogLevelSymbols == false {
            XCTFail("Expected default type \(LogLevelSymbols.self) but returned \(config.logLevelSymbols)")
            return // return early, else code below would stall testing
        }
        
        // swiftlint:disable:next force_cast
        XCTAssertEqual(defaultSymbols, config.logLevelSymbols as! LogLevelSymbols)
    }
    
    func testActivateLogging() {
        sut.activateLogging(true)
        XCTAssertEqual(sut.getIsLoggingActive(), true)
        sut.activateLogging(false)
        XCTAssertEqual(sut.getIsLoggingActive(), false)
    }
    
    func testSetLogProvider() {
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
    
    func testIncludeTimestamp() {
        sut.includeTimestamp(true)
        XCTAssertEqual(sut.getIsTimestampIncluded(), true)
        sut.includeTimestamp(false)
        XCTAssertEqual(sut.getIsTimestampIncluded(), false)
    }
    
    func testGetSubsystemID() {
        sut.setSubsystemID("com.dbyte.myApp")
        XCTAssertEqual(sut.getSubsystemID(), "com.dbyte.myApp")
        sut.setSubsystemID("com.someOther.app")
        XCTAssertEqual(sut.getSubsystemID(), "com.someOther.app")
    }
    
    func testReplaceLogLevelSymbols() {
        let expectedLogLevelSymbols: LogLevelSymbolsInterface =
            sut.replaceLogLevelSymbols()
                .setAction("a")
                .setCanceled("b")
                .setError("c")
                .setOther("d")
                .setSuccess("e")
                .setWarning("f")
                .buildAndReplace()
        
        let cachedLogLevelSymbols = sut.getLogLevelSymbols()
        
        if cachedLogLevelSymbols as? LogLevelSymbols == nil {
            XCTFail("Object cachedLogLevelSymbols could not be downcasted to \(LogLevelSymbols.self). " +
                "Expected concrete type for \(LogLevelSymbolsInterface.self).")
            return // return early, else code below would stall testing
        }
        
        XCTAssertEqual(cachedLogLevelSymbols as? LogLevelSymbols, expectedLogLevelSymbols as? LogLevelSymbols)
    }
    
    func testReplaceSymbols() {
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
        
        if expectedLogLevelSymbols as? LogLevelSymbols == nil {
            XCTFail("Object expectedLogLevelSymbols could not be downcasted to \(LogLevelSymbols.self). " +
                "Expected concrete type for \(LogLevelSymbolsInterface.self).")
            return // return early, else code below would stall testing
        }
        
        XCTAssertNotEqual(expectedLogLevelSymbols as? LogLevelSymbols, defaultLogLevelSymbols as? LogLevelSymbols)
    }
}
