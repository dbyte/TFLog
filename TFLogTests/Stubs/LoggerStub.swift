//
//  LoggerStub.swift
//  TFLogTests
//
//  Created by Tammo on 18.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

@testable import TFLog

struct LoggerStub {
    
    // MARK: - Properties/Init
    
    /// Returns logger instance with an activated logger and a mocked LogProvider
    func activatedAndProviderMock() -> LogInterface {
        let config = LogConfigurationStub().withActivatedLoggingAndProviderMock()
        return Logger(configuration: config, category: "ActivatedLogger")
    }
    
    /// Returns logger instance with an deactivated logger and a mocked LogProvider
    func deactivatedAndProviderMock() -> LogInterface {
        let config = LogConfigurationStub().withDeactivatedLoggingAndProviderMock()
        return Logger(configuration: config, category: "DeactivatedLogger")
    }
}
