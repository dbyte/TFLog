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

class OSLogProviderTests: XCTestCase {
    
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
    
    final func testSetupWithArguments() {
        sut.setup(
            message: message,
            subsystem: subsystem,
            category: category,
            logLevel: .action,
            isPublic: true)
        
        sut.setup(
            message: message,
            subsystem: subsystem,
            category: "\(Self.self)",
            logLevel: .action)
        
        sut.setup(
            message: message,
            subsystem: subsystem)
        
        sut.setup(
            message: message)
    }
    
    final func testSetupWithoutArguments() {
        sut.setup()
    }
    
    final func testSetupWithDifferentLevels() {
        sut.setup(logLevel: .action)
        sut.setup(logLevel: .canceled)
        sut.setup(logLevel: .error)
        sut.setup(logLevel: .other)
        sut.setup(logLevel: .success)
        sut.setup(logLevel: .warning)
    }
    
    final func testExecute() {
        sut.setup(
            message: "A PUBLIC message text.",
            subsystem: subsystem,
            category: category,
            logLevel: .action,
            isPublic: true)
        
        sut.executeLog()
        
        sut.setup(
            message: "A PRIVATE message text.",
            subsystem: subsystem,
            category: category,
            logLevel: .action,
            isPublic: false)
        
        sut.executeLog()
    }
}
