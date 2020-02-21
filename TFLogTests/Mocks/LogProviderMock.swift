//
//  LogProviderMock.swift
//  TFLogTests
//
//  Created by Tammo on 18.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import XCTest
@testable import TFLog

class LogProviderMock: LogProvider {

    // MARK: - Properties/Init
    
    var expectation: XCTestExpectation!
    
    internal var message = ""
    internal var data: Any?
    internal var subsystem = ""
    internal var category = ""
    internal var logLevel: LogLevel?
    internal var timestampStr = ""
    internal var isPublic = true
    
    internal init() {}
    
     // MARK: - Methods
    
    internal func executeLog(with logData: LogData) {
        self.message = logData.message
        self.data = logData.data
        self.subsystem = logData.subsystem
        self.category = logData.category
        self.logLevel = logData.logLevel
        self.timestampStr = logData.timestampStr
        self.isPublic = logData.isPublic
        expectation.fulfill()
    }
    
    internal func setExpectation(_ expectation: XCTestExpectation) {
        self.expectation = expectation
    }
}
