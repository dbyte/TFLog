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
    }
}
