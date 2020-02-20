//
//  LogConfiguration.swift
//  TFLog
//
//  Copyright (c) 2020 dbyte, Tammo Fornalik.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
    
    /// Get subsystem identifier.
    func getSubsystemID() -> String
    
    /// Set subsystem identifier. Should be named in reverse domain notation.
    func setSubsystemID(_ subsystemID: String)
    
    /// Returns true if logging is activated for the logger which has this configuration.
    func getIsLoggingActive() -> Bool
    
    /// Get current log provider object.
    func getLogProvider() -> LogProvider
    
    /// Get all current log level symbols.
    func getLogLevelSymbols() -> LogLevelSymbolsInterface
    
    /// Replaces unicode log level symbols in your logger configuration.
    func replaceLogLevelSymbols() -> LogLevelSymbolBuildable
    
    /// Replace current set of unicode log level symbols with another.
    func replaceSymbols(with symbols: LogLevelSymbolsInterface)
    
    /// Returns true if timestamps are embedded at the beginning of each log message.
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
