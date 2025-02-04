//
//  LogLevelPrefixBuilderTests.swift
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

class LogLevelPrefixBuilderTests: TFLogTestBase {
    
    var sut: LogLevelPrefixBuildable!
    var configuration: LogConfigurable!
    
    //swiftlint:disable:next identifier_name
    private var h: LogLevelPrefixBuilderTestsHelper!
    
    // MARK: - Setup/Teardown
    
    override func setUp() {
        super.setUp()
        configuration = LogConfigurationStub().withActivatedLoggingAndProviderMock()
        sut = LogLevelPrefixBuilder(forConfiguration: configuration)
        h = LogLevelPrefixBuilderTestsHelper()
    }
    
    override func tearDown() {
        configuration = nil
        sut = nil
        h = nil
        super.tearDown()
    }
}

// MARK: - Tests

extension LogLevelPrefixBuilderTests {
    
    final func testSetError() {
        // Given
        h.expectedPrefix = "ThisIsAnExample-Error-Prefix"
        
        // When
        h.builderObject = sut.setError(h.expectedPrefix)
        h.returnedBuilderPrefix = h.builderObject.build().error
        
        h.builderObject.buildAndReplace()
        h.returnedConfigurationPrefix = configuration.getLogLevelPrefixes().error
        
        // Then
        h.setterTest()
    }
    
    final func testSetWarning() {
        // Given
        h.expectedPrefix = "ThisIsAnExample-Warning-Prefix"
        
        // When
        h.builderObject = sut.setWarning(h.expectedPrefix)
        h.returnedBuilderPrefix = h.builderObject.build().warning
        
        h.builderObject.buildAndReplace()
        h.returnedConfigurationPrefix = configuration.getLogLevelPrefixes().warning
        
        // Then
        h.setterTest()
    }
    
    final func testSetSuccess() {
        // Given
        h.expectedPrefix = "ThisIsAnExample-Success-Prefix"
        
        // When
        h.builderObject = sut.setSuccess(h.expectedPrefix)
        h.returnedBuilderPrefix = h.builderObject.build().success
        
        h.builderObject.buildAndReplace()
        h.returnedConfigurationPrefix = configuration.getLogLevelPrefixes().success
        
        // Then
        h.setterTest()
    }
    
    final func testSetAction() {
        // Given
        h.expectedPrefix = "ThisIsAnExample-Action-Prefix"
        
        // When
        h.builderObject = sut.setAction(h.expectedPrefix)
        h.returnedBuilderPrefix = h.builderObject.build().action
        
        h.builderObject.buildAndReplace()
        h.returnedConfigurationPrefix = configuration.getLogLevelPrefixes().action
        
        // Then
        h.setterTest()
    }
    
    final func testSetCanceled() {
        // Given
        h.expectedPrefix = "ThisIsAnExample-Canceled-Prefix"
        
        // When
        h.builderObject = sut.setCanceled(h.expectedPrefix)
        h.returnedBuilderPrefix = h.builderObject.build().canceled
        
        h.builderObject.buildAndReplace()
        h.returnedConfigurationPrefix = configuration.getLogLevelPrefixes().canceled
        
        // Then
        h.setterTest()
    }
    
    final func testSetOther() {
        // Given
        h.expectedPrefix = "ThisIsAnExample-Other-Prefix"
        
        // When
        h.builderObject = sut.setOther(h.expectedPrefix)
        h.returnedBuilderPrefix = h.builderObject.build().other
        
        h.builderObject.buildAndReplace()
        h.returnedConfigurationPrefix = configuration.getLogLevelPrefixes().other
        
        // Then
        h.setterTest()
    }
}

// MARK: - Private helper class

private class LogLevelPrefixBuilderTestsHelper {
    
    var expectedPrefix = ""
    var builderObject: LogLevelPrefixBuildable!
    var returnedBuilderPrefix = ""
    var returnedConfigurationPrefix = ""
    
    func setterTest(
        file: StaticString = #file,
        line: UInt = #line) {
        
        // Then
        XCTAssertEqual(
            returnedBuilderPrefix, expectedPrefix,
            "Expected that build() updates the builder object, but no update was done.",
            file: file,
            line: line)
        
        // Then
        XCTAssertEqual(
            returnedConfigurationPrefix, expectedPrefix,
            "Expected that buildAndReplace() updates current configuration, but no update was done.",
            file: file,
            line: line)
    }
}
