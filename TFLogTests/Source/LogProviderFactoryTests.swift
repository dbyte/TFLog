//
//  LogProviderFactoryTests.swift
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

class LogProviderFactoryTests: TFLogTestBase {
    
    // MARK: - Setup/Teardown
    
    var sut: LogProviderFactory!
    
    override func setUp() {
        super.setUp()
        sut = LogProviderFactory()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests

extension LogProviderFactoryTests {
    
    final func testCreateConsoleLogProvider() {
        // When
        let logProvider: LogProvider = LogProviderFactory.createConsoleProvider()
        
        // Then
        XCTAssertTrue(
            logProvider is ConsoleLogProvider,
            "Expected concrete type \(ConsoleLogProvider.self), but returned \(logProvider.self)")
    }
    
    final func testCreateOSLogProvider() {
        // When
        let logProvider: LogProvider = LogProviderFactory.createOSLogProvider()
        
        // Then
        XCTAssertTrue(
            logProvider is OSLogProvider,
            "Expected concrete type \(OSLogProvider.self), but returned \(logProvider.self)")
    }
}
