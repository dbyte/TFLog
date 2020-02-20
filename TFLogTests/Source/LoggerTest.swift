//
//  LoggerTest.swift
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

class LoggerTest: TFLogTestBase {
    
    // MARK: - Setup/Teardown
    
    var sut: LogInterface!

    override func setUp() {
        super.setUp()
        sut = LoggerStub().activatedAndProviderMock()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
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
        
        var expectationBag = [XCTestExpectation]()
        
        expectationBag.append(getNewLogExecutionExpectation(inverted: true))
        providerMock.setExpectation(expectationBag.last!)
        sut.log("This should not be logged - logger is deactivated")
        
        expectationBag.append(getNewLogExecutionExpectation(inverted: true))
        providerMock.setExpectation(expectationBag.last!)
        sut.newLine()
        
        expectationBag.append(getNewLogExecutionExpectation(inverted: true))
        providerMock.setExpectation(expectationBag.last!)
        sut.verticalDivider()
        
        wait(for: expectationBag, timeout: 1)
    }
    
    func testLogShouldComposeValidMessage() {
        sut = LoggerStub().activatedAndProviderMock()
        // swiftlint:disable:next force_cast
        let providerMock = sut.getConfiguration().getLogProvider() as! LogProviderMock
        
        providerMock.setExpectation(setLogExecutionExpectation())
        sut.log("Log_HeaderOnly")
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertEqual(providerMock.message, "Log_HeaderOnly")
        
        providerMock.setExpectation(setLogExecutionExpectation())
        sut.log("Log_Header+Level", lev: .action)
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertEqual(providerMock.message, "📘 Log_Header+Level")
        XCTAssertEqual(providerMock.logLevel, .action)
        
        providerMock.setExpectation(setLogExecutionExpectation())
        sut.log("Log_Header+Data", data: "SomeDataAsText")
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertEqual(providerMock.message, "Log_Header+Data" + "\n" + "▶️SomeDataAsText◀️")
        
        providerMock.setExpectation(setLogExecutionExpectation())
        sut.log("Log_Header+Data+Level", data: "SomeDataAsText", lev: .success)
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertEqual(providerMock.message, "📗 Log_Header+Data+Level" + "\n" + "▶️SomeDataAsText◀️")
        XCTAssertEqual(providerMock.logLevel, .success)
        
        providerMock.setExpectation(setLogExecutionExpectation())
        sut.log(data: "Log_TheDataOnly")
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertEqual(providerMock.message, "▶️Log_TheDataOnly◀️")
        
        providerMock.setExpectation(setLogExecutionExpectation())
        sut.log(data: "Log_Data+Level", lev: .other)
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertEqual(providerMock.message, "📔" + "\n" + "▶️Log_Data+Level◀️")
        XCTAssertEqual(providerMock.logLevel, .other)
        
        providerMock.setExpectation(setLogExecutionExpectation())
        sut.log("")
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertEqual(providerMock.message, "")
    }
    
    func testNewLine() {
        sut = LoggerStub().activatedAndProviderMock()
        // swiftlint:disable:next force_cast
        let providerMock = sut.getConfiguration().getLogProvider() as! LogProviderMock
        
        let aExpectation = setLogExecutionExpectation()
        aExpectation.expectedFulfillmentCount = 2
        
        providerMock.setExpectation(aExpectation)
        sut.log("Log_HeaderOnly")
        sut.newLine()
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertEqual(providerMock.message, "Log_HeaderOnly" + "\n")
    }
    
    func testVerticalDivider() {
        sut = LoggerStub().activatedAndProviderMock()
        // swiftlint:disable:next force_cast
        let providerMock = sut.getConfiguration().getLogProvider() as! LogProviderMock
        
        let aExpectation = setLogExecutionExpectation()
        aExpectation.expectedFulfillmentCount = 2
        
        providerMock.setExpectation(aExpectation)
        sut.log("Log_HeaderOnly")
        sut.verticalDivider()
        waitForExpectations(timeout: timeout, handler: nil)
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
            pattern: "(\\d{4})-(\\d{2})-(\\d{2})T(\\d{2})\\:(\\d{2})\\:(\\d{2})([zZ]|[+-](\\d{2})\\:(\\d{2}))")
        
        // Execute
        providerMock.setExpectation(setLogExecutionExpectation())
        sut.log("Log_WithTimestamp")
        waitForExpectations(timeout: timeout, handler: nil)
        
        // Search for timestamp in  log message
        let range = NSRange(location: 0, length: providerMock.message.count)
        let regexMatches = regex.matches(in: providerMock.message, options: [], range: range)
        XCTAssertTrue(regexMatches.count > 0, "ISO Date should be present but could not be extracted to regex array.")
        
        let timestampString = (regexMatches.map {
            String(providerMock.message[Range($0.range, in: providerMock.message)!])
        }).first
        
        XCTAssertNotNil(timestampString, "ISO Date should be present but could not be extracted")
        
        // Check if timestamp an message were successfully composed
        XCTAssertEqual(providerMock.message, "\(timestampString ?? "") Log_WithTimestamp")
    }
}

private extension LoggerTest {
    
    // Returns a new expectation reference with fixed description
    func getNewLogExecutionExpectation(inverted: Bool = false) -> XCTestExpectation {
        let expectation = XCTestExpectation(description: "Log execution method should be called")
        expectation.isInverted = inverted
        return expectation
    }
    
    // Sets the instance's expectation with a fixed description and returns a reference to it.
    func setLogExecutionExpectation(inverted: Bool = false) -> XCTestExpectation {
        return self.expectation(description: "Log execution method should be called")
    }
}
