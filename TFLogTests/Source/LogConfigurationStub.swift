//
//  LogConfigurationStub.swift
//  TFLogTests
//
//  Created by Tammo on 18.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import XCTest
@testable import TFLog

struct LogConfigurationStub {

    // MARK: - Properties/Init
    
    let concreteLogConfiguration: LogConfigurable = LogConfiguration()
    let concreteLogConfigurationFromFactory: LogConfigurable = LoggerFactory.createLogConfiguration()
}
