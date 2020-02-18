//
//  LogConfigurationStub.swift
//  TFLogTests
//
//  Created by Tammo on 18.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

@testable import TFLog

struct LogConfigurationStub {

    // MARK: - Properties/Init
    
    func withActivatedLoggingAndProviderMock() -> LogConfigurable {
        let config = LogConfiguration()
        config.setLogProvider(LogProviderMock())
        config.activateLogging(true)
        return config
    }
    
    func withDeactivatedLoggingAndProviderMock() -> LogConfigurable {
        let config = LogConfiguration()
        config.setLogProvider(LogProviderMock())
        config.activateLogging(false)
        return config
    }
}
