//
//  LogProviderMock.swift
//  TFLogTests
//
//  Created by Tammo on 18.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import TFLog
import XCTest

class LogProviderMock: LogProvider {
    
    // MARK: - Properties/Init
    
    var expectation: XCTestExpectation!
    
    var message: String = ""
    var subsystem: String = ""
    var category: String = ""
    var logLevel: LogLevel?
    var isPublic: Bool = true
    
    internal init() {}
    
     // MARK: - Methods
    
    func executeLog() {
        expectation.fulfill()
    }
    
    func setup(message: String?, subsystem: String?, category: String?, logLevel: LogLevel?, isPublic: Bool?) {
        self.message = message ?? ""
        self.subsystem = subsystem ?? ""
        self.category = category ?? ""
        self.logLevel = logLevel
        self.isPublic = isPublic ?? true
    }
    
    internal func setExpectation(_ expectation: XCTestExpectation) {
        self.expectation = expectation
    }
}
