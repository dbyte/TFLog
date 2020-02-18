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
public protocol LogConfigurable {
    
    ///
    func activateLogging(_ isLoggingActive: Bool)
    
    ///
    func setLogProvider(_ logProvider: LogProvider)
    
    ///
    func includeTimestamp(_ isTimestampIncluded: Bool)
    
    ///
    func getSubsystemID() -> String?
    
    ///
    func setSubsystemID(_ subsystemID: String)
    
    /// Unicode log level symbols can be built and/or replaced here.
    func replaceLogLevelSymbols() -> LogLevelSymbolBuildable
    
    ///
    func getIsLoggingActive() -> Bool
    
    ///
    func getLogProvider() -> LogProvider
    
    ///
    func getLogLevelSymbols() -> LogLevelSymbolsInterface
    
    ///
    func getIsTimestampIncluded() -> Bool
}

// MARK: Configuration for logger

/// Holds configuration data for the logger and provides handling of a configuration.
///
/// - See also: `Logging.configure`
internal class LogConfiguration: LogConfigurable {
    
    // MARK: - Properties/Init
    
    internal private(set) var isLoggingActive: Bool
    internal private(set) var logProvider: LogProvider
    internal private(set) var isTimestampIncluded: Bool
    internal private(set) var subsystemID: String?
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
    
    func getSubsystemID() -> String? {
        return subsystemID ?? ""
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
    
    // Below are some funcs which need to conform to LogConfigurable. This is because we do not
    // want to expose the fields of this class to the protocol.
    
    func getIsLoggingActive() -> Bool{
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
