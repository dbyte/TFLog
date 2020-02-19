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
        
        XCTAssertEqual(defaultSymbols.action, config.logLevelSymbols.action)
        XCTAssertEqual(defaultSymbols.canceled, config.logLevelSymbols.canceled)
        XCTAssertEqual(defaultSymbols.error, config.logLevelSymbols.error)
        XCTAssertEqual(defaultSymbols.other, config.logLevelSymbols.other)
        XCTAssertEqual(defaultSymbols.success, config.logLevelSymbols.success)
        XCTAssertEqual(defaultSymbols.warning, config.logLevelSymbols.warning)
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
        let _: LogLevelSymbolsInterface =
            sut.replaceLogLevelSymbols()
                .setAction("a")
                .setCanceled("b")
                .setError("c")
                .setOther("d")
                .setSuccess("e")
                .setWarning("f")
                .buildAndReplace()
        
        let cachedLogLevels = sut.getLogLevelSymbols()
        
        XCTAssertEqual(cachedLogLevels.action, "a")
        XCTAssertEqual(cachedLogLevels.canceled, "b")
        XCTAssertEqual(cachedLogLevels.error, "c")
        XCTAssertEqual(cachedLogLevels.other, "d")
        XCTAssertEqual(cachedLogLevels.success, "e")
        XCTAssertEqual(cachedLogLevels.warning, "f")
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
        
        XCTAssertNotEqual(expectedLogLevelSymbols.action, defaultLogLevelSymbols.action)
        XCTAssertNotEqual(expectedLogLevelSymbols.canceled, defaultLogLevelSymbols.canceled)
        XCTAssertNotEqual(expectedLogLevelSymbols.error, defaultLogLevelSymbols.error)
        XCTAssertNotEqual(expectedLogLevelSymbols.other, defaultLogLevelSymbols.other)
        XCTAssertNotEqual(expectedLogLevelSymbols.success, defaultLogLevelSymbols.success)
        XCTAssertNotEqual(expectedLogLevelSymbols.warning, defaultLogLevelSymbols.warning)
    }
}
