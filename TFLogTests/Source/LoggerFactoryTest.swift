//
//  LoggerFactoryTest.swift
//  TFLogTests
//
//  Created by Tammo on 18.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import XCTest
@testable import TFLog

class LoggerFactoryTest: XCTestCase {
    
    // MARK: - Setup/Teardown
    
    var sut: LoggerFactory!
    
    override func setUp() {
        super.setUp()
        sut = LoggerFactory()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests

extension LoggerFactoryTest {
    
    func testCreateLogger() {
        let configuration = LogConfigurationStub().withActivatedLoggingAndProviderMock()
        configuration.setSubsystemID("com.test.xyz")
        let logger = LoggerFactory.createLogger(configuration: configuration, category: "Some Category Name")
        
        XCTAssertTrue(logger is Logger, "Expected concrete type \(Logger.self), but returned \(logger.self)")
    }
    
    func testCreateLogConfiguration() {
        let configuration = LoggerFactory.createLogConfiguration()

        XCTAssertTrue(
            configuration is LogConfiguration,
            "Expected concrete type \(LogConfiguration.self), but returned \(configuration.self)")
    }
}
