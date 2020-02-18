//
//  LoggerTest.swift
//  TFLogTests
//
//  Created by Tammo on 18.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import XCTest
@testable import TFLog

class LoggerTest: XCTestCase {
    
    // MARK: - Setup
    
    var sut: Logger!

    override func setUp() {
        super.setUp()
        let config = LogConfigurationStub().concreteLogConfiguration
        config.setLogProvider(LogProviderMock())
        sut = Logger(configuration: config, category: "LoggerTest")
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    // MARK: - Tests

    func testGetConfigurationShouldReturnValidObject() {
        XCTAssertNotNil(sut.getConfiguration())
    }
    
    func testSetConfigurationShouldReplaceConfiguration() {
        // Note we don't test class "Configuration" itself. We only test the proper work of method
        // "setConfiguration" within the sut.
        
        let originalConfig = LogConfigurationStub().concreteLogConfiguration
        originalConfig.activateLogging(true)
        sut = Logger(configuration: originalConfig, category: "LoggerTest")
        
        let newConfig = LogConfigurationStub().concreteLogConfiguration
        newConfig.activateLogging(false)
        
        sut.setConfiguration(with: newConfig)
        
        XCTAssertEqual(originalConfig.getIsLoggingActive(), true, "Check stub! Stub property must not be static.")
        XCTAssertEqual(newConfig.getIsLoggingActive(), false,  "Check stub! Stub property must not be static.")
        
        XCTAssertNotEqual(sut.getConfiguration().getIsLoggingActive(), originalConfig.getIsLoggingActive())
    }
    
    func testShouldNotLogIfLoggingIsDeactivated() {
        let providerMock = LogProviderMock()
        var aExpectation: XCTestExpectation
        
        let currentLoggerConfig = sut.getConfiguration()
        currentLoggerConfig.activateLogging(false) // switch off logger
        currentLoggerConfig.setLogProvider(providerMock)
        
        func getNewExpectation() -> XCTestExpectation {
            let expectation = self.expectation(description: "LogExecutionMethodWasCalled")
            expectation.isInverted = true // invert!
            return expectation
        }
        
        aExpectation = getNewExpectation()
        providerMock.setExpectation(aExpectation)
        sut.log("This should not be logged - logger is deactivated")
        waitForExpectations(timeout: 1, handler: nil)
        
        aExpectation = getNewExpectation()
        providerMock.setExpectation(aExpectation)
        sut.newLine()
        waitForExpectations(timeout: 1, handler: nil)
        
        aExpectation = getNewExpectation()
        providerMock.setExpectation(aExpectation)
        sut.verticalDivider()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLogShouldComposeValidMessage() {
        let providerMock = LogProviderMock()
        var aExpectation: XCTestExpectation
        
        let currentLoggerConfig = sut.getConfiguration()
        currentLoggerConfig.activateLogging(true)
        currentLoggerConfig.setLogProvider(providerMock)
        
        func getNewExpectation() -> XCTestExpectation {
            return self.expectation(description: "LogExecutionMethodWasCalled")
        }
        
        aExpectation = getNewExpectation()
        providerMock.setExpectation(aExpectation)
        sut.log("Log_HeaderOnly")
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(providerMock.message, "Log_HeaderOnly")
        
        aExpectation = getNewExpectation()
        providerMock.setExpectation(aExpectation)
        sut.log("Log_Header+Level", lev: .action)
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(providerMock.message, "📘 Log_Header+Level")
        XCTAssertEqual(providerMock.logLevel, .action)
        
        aExpectation = getNewExpectation()
        providerMock.setExpectation(aExpectation)
        sut.log("Log_Header+Data", data: "SomeDataAsText")
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(providerMock.message, "Log_Header+Data" + "\n" + "▶️SomeDataAsText◀️")
        
        aExpectation = getNewExpectation()
        providerMock.setExpectation(aExpectation)
        sut.log("Log_Header+Data+Level", data: "SomeDataAsText", lev: .success)
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(providerMock.message, "📗 Log_Header+Data+Level" + "\n" + "▶️SomeDataAsText◀️")
        XCTAssertEqual(providerMock.logLevel, .success)
        
        aExpectation = getNewExpectation()
        providerMock.setExpectation(aExpectation)
        sut.log(data: "Log_TheDataOnly")
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(providerMock.message, "▶️Log_TheDataOnly◀️")
        
        aExpectation = getNewExpectation()
        providerMock.setExpectation(aExpectation)
        sut.log(data: "Log_Data+Level", lev: .other)
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(providerMock.message, "📔" + "\n" + "▶️Log_Data+Level◀️")
        XCTAssertEqual(providerMock.logLevel, .other)
        
        aExpectation = getNewExpectation()
        providerMock.setExpectation(aExpectation)
        sut.log(lev: .warning)
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(providerMock.message, "📙")
        XCTAssertEqual(providerMock.logLevel, .warning)
        
        aExpectation = getNewExpectation()
        providerMock.setExpectation(aExpectation)
        sut.log("")
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(providerMock.message, "")
    }
    
    func testNewLine() {
        let providerMock = LogProviderMock()
        let aExpectation = self.expectation(description: "LogExecutionMethodWasCalled")
        aExpectation.expectedFulfillmentCount = 2
        
        let currentLoggerConfig = sut.getConfiguration()
        currentLoggerConfig.activateLogging(true)
        currentLoggerConfig.setLogProvider(providerMock)
        
        providerMock.setExpectation(aExpectation)
        sut.log("Log_HeaderOnly")
        sut.newLine()
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(providerMock.message, "Log_HeaderOnly" + "\n")
    }
    
    func testVerticalDivider() {
        let providerMock = LogProviderMock()
        let aExpectation = self.expectation(description: "LogExecutionMethodWasCalled")
        aExpectation.expectedFulfillmentCount = 2
        
        let currentLoggerConfig = sut.getConfiguration()
        currentLoggerConfig.activateLogging(true)
        currentLoggerConfig.setLogProvider(providerMock)
        
        providerMock.setExpectation(aExpectation)
        sut.log("Log_HeaderOnly")
        sut.verticalDivider()
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(providerMock.message, "Log_HeaderOnly" + String(repeating: "-", count: 80))
    }
    
    func testShouldApplyTimestampIfActivated() {
        let providerMock = LogProviderMock()
        let currentLoggerConfig = sut.getConfiguration()
        currentLoggerConfig.activateLogging(true)
        currentLoggerConfig.setLogProvider(providerMock)
        currentLoggerConfig.includeTimestamp(true) // activate timestamp
        
        // Regex pattern for the ISO8601 formatted timestamp.
        let regex = try! NSRegularExpression(
            pattern: "(\\d{4})-(\\d{2})-(\\d{2})T(\\d{2})\\:(\\d{2})\\:(\\d{2})[+-](\\d{2})\\:(\\d{2})")
        
        // Execute
        providerMock.setExpectation(expectation(description: "LogExecutionMethodWasCalled"))
        sut.log("Log_WithTimestamp")
        waitForExpectations(timeout: 1, handler: nil)
        
        // Search for timestamp in  log message
        let range = NSRange(location: 0, length: providerMock.message.count)
        let regexMatches = regex.matches(in: providerMock.message, options: [], range: range)
        XCTAssertTrue(regexMatches.count > 0, "ISO Date should be present but could not be extracted")
        
        guard let timestampString = (regexMatches.map {
            String(providerMock.message[Range($0.range, in: providerMock.message)!])
        }).first else {
            XCTFail( "ISO Date should be present but could not be extracted")
            return
        }
        
        // Check if timestamp an message were successfully composed
        XCTAssertEqual(providerMock.message, "\(timestampString) Log_WithTimestamp")
    }
}
