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
    
    // MARK: - Setup/Teardown
    
    var sut: LogInterface!

    override func setUp() {
        super.setUp()
        sut = LoggerStub().activatedAndProviderMock()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
    
// MARK: - Tests

extension LoggerTest {

    func testGetConfigurationShouldReturnValidObject() {
        XCTAssertNotNil(sut.getConfiguration())
    }
    
    func testSetConfigurationShouldReplaceConfiguration() {
        // Note we don't test class "Configuration" itself. We only test the proper work of method
        // "setConfiguration" within the sut.
        let originalConfig = LogConfigurationStub().withActivatedLoggingAndProviderMock()
        sut = Logger(configuration: originalConfig, category: "")
        
        let newConfig = LogConfigurationStub().withDeactivatedLoggingAndProviderMock()
        sut.setConfiguration(with: newConfig)
        
        XCTAssertNotEqual(sut.getConfiguration().getIsLoggingActive(), originalConfig.getIsLoggingActive())
    }
    
    func testShouldNotLogIfLoggingIsDeactivated() {
        sut = LoggerStub().deactivatedAndProviderMock()
        // swiftlint:disable:next force_cast
        let providerMock = sut.getConfiguration().getLogProvider() as! LogProviderMock
        
        func getNewExpectation() -> XCTestExpectation {
            let expectation = self.expectation(description: "LogExecutionMethodWasCalled")
            expectation.isInverted = true // invert!
            return expectation
        }
        
        var aExpectation: XCTestExpectation
        
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
        sut = LoggerStub().activatedAndProviderMock()
        // swiftlint:disable:next force_cast
        let providerMock = sut.getConfiguration().getLogProvider() as! LogProviderMock
        
        func getNewExpectation() -> XCTestExpectation {
            return self.expectation(description: "LogExecutionMethodWasCalled")
        }
        
        var aExpectation: XCTestExpectation
        
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
        sut.log("")
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(providerMock.message, "")
    }
    
    func testNewLine() {
        sut = LoggerStub().activatedAndProviderMock()
        // swiftlint:disable:next force_cast
        let providerMock = sut.getConfiguration().getLogProvider() as! LogProviderMock
        
        let aExpectation = self.expectation(description: "LogExecutionMethodWasCalled")
        aExpectation.expectedFulfillmentCount = 2
        
        providerMock.setExpectation(aExpectation)
        sut.log("Log_HeaderOnly")
        sut.newLine()
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(providerMock.message, "Log_HeaderOnly" + "\n")
    }
    
    func testVerticalDivider() {
        sut = LoggerStub().activatedAndProviderMock()
        // swiftlint:disable:next force_cast
        let providerMock = sut.getConfiguration().getLogProvider() as! LogProviderMock
        
        let aExpectation = self.expectation(description: "LogExecutionMethodWasCalled")
        aExpectation.expectedFulfillmentCount = 2
        
        providerMock.setExpectation(aExpectation)
        sut.log("Log_HeaderOnly")
        sut.verticalDivider()
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(providerMock.message, "Log_HeaderOnly" + String(repeating: "-", count: 80))
    }
    
    func testShouldApplyTimestampIfActivated() {
        sut = LoggerStub().activatedAndProviderMock()
        sut.getConfiguration().includeTimestamp(true) // activate timestamp
        
        // swiftlint:disable:next force_cast
        let providerMock = sut.getConfiguration().getLogProvider() as! LogProviderMock
        
        // Regex pattern for the ISO8601 formatted timestamp.
        // swiftlint:disable:next force_try
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
