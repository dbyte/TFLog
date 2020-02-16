//
//  LogConfiguration.swift
//  TFLog
//
//  Created by Tammo on 16.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

// MARK: Configuration for the logger

/// Holds configuration data for the logger.
///
/// If you need only one configuration for your whole module, you would wrap an instance of this class
/// in a new protocol which then provides the `loggerConfiguration` for protocol `Logging`.
///
/// If you need a special configuration within a single type which conforms to `Logging`, you just
/// place a definition  `var loggerConfiguration: LogConfiguration` inside that type (which actually overwrites
/// the default computed value in the protocol's extension) and configure it with the values of your needs.
///
/// - See also: `Logging.loggerConfiguration`
public class LogConfiguration {
    
    // MARK: - Properties/Init
    
    private(set) var isLoggingActive: Bool
    private(set) var logLevelSymbols: LogLevelSymbols
    
    public init() {
        self.isLoggingActive = true // logging is active by default
        self.logLevelSymbols = LogLevelSymbols() // Set default log level symbols
    }
}

// MARK: - Public Methods

public extension LogConfiguration {
    
    func activateLogging(_ isLoggingActive: Bool) {
        self.isLoggingActive = isLoggingActive
    }
    
    /// External configuration: symbols can be built via LogLevelSymbolBuilder and then are injected here.
    ///
    /// - Parameter with: A customized `LogLevelSymbols` object. You can build one with `LogLevelSymbolBuilder` .
    func replaceSymbols(with symbols: LogLevelSymbols) {
        self.logLevelSymbols = symbols
    }
}
