//
//  LogConfiguration.swift
//  TFLog
//
//  Created by Tammo on 16.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

// MARK: Configuration for logger

/// Holds configuration data for the logger.
///
/// - See also: `Logging.configure`
public class LogConfiguration {
    
    // MARK: - Properties/Init
    
    public private(set) var isLoggingActive: Bool
    internal private(set) var logLevelSymbols: LogLevelSymbols
    
    public init() {
        self.isLoggingActive = true // logging is active by default
        self.logLevelSymbols = LogLevelSymbols() // Set default log level symbols
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
    
    /// Unicode log level symbols can be built and/or replaced here.
    final func replaceLogLevelSymbols() -> LogLevelSymbolBuilder {
        return LogLevelSymbolBuilder(forConfiguration: self)
    }
}
