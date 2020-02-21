//
//  FoundationExtensionTests.swift
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

class StringExtensionTests: TFLogTestBase {
    
    // MARK: - Setup/Teardown
    
    var sut: String!
    
    override func setUp() {
        super.setUp()
        sut = String()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests

extension StringExtensionTests {
    
    func testRemoveExtraSpaces() {
        // Given
        var aString = "  this   is    a  test.\n\n    "
        var expectedString = "this is a test.\n\n"
        
        // When
        var result = aString.removeExtraSpaces()
        
        // Then
        XCTAssertEqual(result, expectedString)
        
        // MARK: -
        
        // Given
        aString = "This is a legal text without trailing & leading spaces and without extra spaces."
        expectedString = aString
        
        // When
        result = aString.removeExtraSpaces()
        
        // Then
        XCTAssertEqual(result, expectedString)
        
        // MARK: -
        
        // Given
        aString = "This is a text with trailing space only   "
        expectedString = "This is a text with trailing space only"
        
        // When
        result = aString.removeExtraSpaces()
        
        // Then
        XCTAssertEqual(result, expectedString)
        
        // MARK: -
        
        // Given
        aString = "   While this is a text with leading space only"
        expectedString = "While this is a text with leading space only"
        
        // When
        result = aString.removeExtraSpaces()
        
        // Then
        XCTAssertEqual(result, expectedString)
        
        // MARK: -
        
        // Given
        aString = "\nThis is a text with leading newline. Newlines should NOT be removed. Text should be unchanged."
        expectedString = aString
        
        // When
        result = aString.removeExtraSpaces()
        
        // Then
        XCTAssertEqual(result, expectedString)
        
        // MARK: -
        
        // Given
        aString = "This is a text with 2 trailing newlines. " +
        "Newlines should NOT be removed. Text should be unchanged.\n\n"
        expectedString = aString
        
        // When
        result = aString.removeExtraSpaces()
        
        // Then
        XCTAssertEqual(result, expectedString)
    }
}
