//
//  LogConfiguration.swift
//  TFLog
//
//  Created by Tammo on 16.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import os.log

// MARK: Interface for LogConfiguration

/// Interface for configuration of the Logger.
public protocol LogConfigurable {
    
    /// Switch logging on/off
    func activateLogging(_ isLoggingActive: Bool)
    
    /// Choose a log provider (infrastructure) which conforms to LogInterface.
    /// In your host app, you may do so by calling a method of LogProviderFactory.
    /// Current default is `OSLogProvider`.
    ///
    /// - See also: `LogProviderFactory`
    func setLogProvider(_ logProvider: LogProvider)
    
    /// Show/hide timestamps at start of each log message. It is switched off per default.
    /// May be useful if ConsoleLogProvider is your current log provider.
    func includeTimestamp(_ isTimestampIncluded: Bool)
    
    ///
    func getSubsystemID() -> String
    
    ///
    func setSubsystemID(_ subsystemID: String)
    
    ///
    func getIsLoggingActive() -> Bool
    
    ///
    func getLogProvider() -> LogProvider
    
    ///
    func getLogLevelSymbols() -> LogLevelSymbolsInterface
    
    /// Replaces unicode log level symbols in your logger configuration.
    func replaceLogLevelSymbols() -> LogLevelSymbolBuildable
    
    /// Replace current set of unicode log level symbols with another.
    func replaceSymbols(with symbols: LogLevelSymbolsInterface)
    
    ///
    func getIsTimestampIncluded() -> Bool
}

// MARK: Configuration for logger

/// Holds configuration data for the logger and provides handling of a configuration.
///
/// - See also: `Logging.setConfiguration`
internal class LogConfiguration: LogConfigurable {
    
    // MARK: - Properties/Init
    
    internal private(set) var isLoggingActive: Bool
    internal private(set) var logProvider: LogProvider
    internal private(set) var isTimestampIncluded: Bool
    internal private(set) var subsystemID: String
    internal private(set) var logLevelSymbols: LogLevelSymbolsInterface
    
    internal init() {
        self.isLoggingActive = true // logging is active by default
        self.logProvider = OSLogProvider() // Apple os.log framework is default
        self.isTimestampIncluded = false
        self.logLevelSymbols = LogLevelSymbols() // Set default log level symbols
        self.subsystemID = ""
    }
}

// MARK: - Internal Methods

internal extension LogConfiguration {
    
    func activateLogging(_ isLoggingActive: Bool) {
        self.isLoggingActive = isLoggingActive
    }
    
    func setLogProvider(_ logProvider: LogProvider) {
        self.logProvider = logProvider
    }
    
    func includeTimestamp(_ isTimestampIncluded: Bool) {
        self.isTimestampIncluded = isTimestampIncluded
    }
    
    func getSubsystemID() -> String {
        return subsystemID
    }
    
    func setSubsystemID(_ subsystemID: String) {
        self.subsystemID = subsystemID
    }
    
    /// Unicode log level symbols can be built and/or replaced here.
    func replaceLogLevelSymbols() -> LogLevelSymbolBuildable {
        return LogLevelSymbolBuilder(forConfiguration: self)
    }
    
    func replaceSymbols(with symbols: LogLevelSymbolsInterface) {
        self.logLevelSymbols = symbols
    }
    
    func getIsLoggingActive() -> Bool {
        return isLoggingActive
    }
    
    func getLogProvider() -> LogProvider {
        return logProvider
    }
    
    func getLogLevelSymbols() -> LogLevelSymbolsInterface {
        return logLevelSymbols
    }
    
    func getIsTimestampIncluded() -> Bool {
        return isTimestampIncluded
    }
}
