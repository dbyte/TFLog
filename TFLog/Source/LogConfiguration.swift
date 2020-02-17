//
//  LogConfiguration.swift
//  TFLog
//
//  Created by Tammo on 16.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import os.log

// MARK: Configuration for logger

/// Holds configuration data for the logger.
///
/// - See also: `Logging.configure`
public class LogConfiguration {
    
    // MARK: - Properties/Init
    
    public private(set) var isLoggingActive: Bool
    internal private(set) var isTimestampIncluded: Bool
    internal private(set) var subsystemID: String?
    internal private(set) var category: String
    internal private(set) var logLevelSymbols: LogLevelSymbols
    
    public init() {
        self.isLoggingActive = true // logging is active by default
        self.isTimestampIncluded = false
        self.logLevelSymbols = LogLevelSymbols() // Set default log level symbols
        self.subsystemID = Bundle.main.bundleIdentifier
        self.category = ""
    }
}

// MARK: - Internal Methods

internal extension LogConfiguration {
    
    func replaceSymbols(with symbols: LogLevelSymbols) {
        self.logLevelSymbols = symbols
    }
}

// MARK: - Public Methods

public extension LogConfiguration {
    
    final func activateLogging(_ isLoggingActive: Bool) {
        self.isLoggingActive = isLoggingActive
    }
    
    final func includeTimestamp(_ isTimestampIncluded: Bool) {
        self.isTimestampIncluded = isTimestampIncluded
    }
    
    final func subsystemID(_ subsystemID: String) {
        self.subsystemID = subsystemID
    }
    
    final func category(_ category: String) {
        self.category = category
    }
    
    /// Unicode log level symbols can be built and/or replaced here.
    final func replaceLogLevelSymbols() -> LogLevelSymbolBuilder {
        return LogLevelSymbolBuilder(forConfiguration: self)
    }
}
