//
//  OSLogProviderTests.swift
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

class OSLogProviderTests: TFLogTestBase {
    
    // MARK: - Setup/Teardown
    
    // We test the concrete class here - not the protocol it's conforming to.
    var sut: OSLogProvider!
    
    var message = "A message text."
    var subsystem = "com.tflog.oslog.unittest"
    var category = "TFLog Unit Test"
    var logLevel: LogLevel?
    var isPublic: Bool?
    
    override func setUp() {
        super.setUp()
        sut = OSLogProvider()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests

extension OSLogProviderTests {
    
    final func testExecuteWithData() {
        // Given
        let logData = LogData(
            message: message,
            data: nil,
            subsystem: subsystem,
            category: category,
            logLevel: .action,
            timestampStr: nil,
            isPublic: true)
        
        // When
        sut.executeLog(with: logData)
        
        // Then?
    }
    
    final func testSetupWithEmptyData() {
        // Given
        let logData = LogData()
        
        // When
        sut.executeLog(with: logData)
        
        // Then?
    }
    
    final func testExecuteWithDifferentLevels() {
        // Given
        var logData = LogData(
            message: message,
            data: nil,
            subsystem: subsystem,
            category: category,
            logLevel: .action,
            timestampStr: nil,
            isPublic: false)
        
        // When
        sut.executeLog(with: logData)
        
        logData.logLevel = .canceled
        sut.executeLog(with: logData)
        
        logData.logLevel = .error
        sut.executeLog(with: logData)
        
        logData.logLevel = .other
        sut.executeLog(with: logData)
        
        logData.logLevel = .success
        sut.executeLog(with: logData)
        
        logData.logLevel = .warning
        sut.executeLog(with: logData)
        
        logData.logLevel = .none
        sut.executeLog(with: logData)
        
        // Then?
    }
}
