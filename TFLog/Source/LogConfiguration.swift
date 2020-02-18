//
//  LogConfiguration.swift
//  TFLog
//
//  Created by Tammo on 16.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import os.log

// MARK: Interface for LogConfiguration

///
protocol LogConfigurable {
}

// MARK: Configuration for logger

/// Holds configuration data for the logger.
///
/// - See also: `Logging.configure`
open class LogConfiguration: LogConfigurable {
    
    // MARK: - Properties/Init
    
    public private(set) var isLoggingActive: Bool
    internal private(set) var logProvider: LogProvider
    internal private(set) var isTimestampIncluded: Bool
    internal private(set) var subsystemID: String?
    internal private(set) var logLevelSymbols: LogLevelSymbols
    
    public init() {
        self.isLoggingActive = true // logging is active by default
        self.logProvider = OSLogProvider() // Apple os.log framework is default
        self.isTimestampIncluded = false
        self.logLevelSymbols = LogLevelSymbols() // Set default log level symbols
        self.subsystemID = ""
    }
    
    // MARK: - Open Methods
    // Warning: Open methods cannot be overriden when they reside within extensions, so we leave them here!
    
    open func activateLogging(_ isLoggingActive: Bool) {
        self.isLoggingActive = isLoggingActive
    }
    
    open func setLogProvider(_ logProvider: LogProvider) {
        self.logProvider = logProvider
    }
    
    open func includeTimestamp(_ isTimestampIncluded: Bool) {
        self.isTimestampIncluded = isTimestampIncluded
    }
    
    open func setSubsystemID(_ subsystemID: String) {
        self.subsystemID = subsystemID
    }
    
    /// Unicode log level symbols can be built and/or replaced here.
    open func replaceLogLevelSymbols() -> LogLevelSymbolBuildable {
        return LogLevelSymbolBuilder(forConfiguration: self)
    }
}

// MARK: - Internal Methods

internal extension LogConfiguration {
    
    func replaceSymbols(with symbols: LogLevelSymbols) {
        self.logLevelSymbols = symbols
    }
}
