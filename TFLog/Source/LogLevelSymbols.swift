//
//  LogLevelSymbols.swift
//  TFLog
//
//  Created by Tammo on 16.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

// MARK: - Log level unicode symbols

// Note: Type needs to be public for the public result of instance method LogLevelSymbolBuilder.build() .
/// Log level unicode symbols customization can be done via `LogLevelSymbolBuilder` followed by injection
/// into instance method `LogConfiguration.replaceSymbols(:)`
/// - See also: `LogLevelSymbolBuilder`
public struct LogLevelSymbols {
    
    internal var error: String
    internal var warning: String
    internal var success: String
    internal var action: String
    internal var canceled: String
    internal var other: String
    
    // Set default log level symbols
    internal init() {
        self.error = "📕"
        self.warning = "📙"
        self.success = "📗"
        self.action = "📘"
        self.canceled = "📓"
        self.other = "📔"
    }
}

// MARK: - Builder for replacing log level unicode symbols

/// Log level unicode symbols customization.
///
/// Use this builder to create a new set of symbols or just set the ones you want to overwrite
/// and afterwards inject it via `LogConfiguration.replaceSymbols(:)` .
/// - See also: `LogConfiguration`
public class LogLevelSymbolBuilder {
    
    private var logLevelSymbols: LogLevelSymbols
    private let config: LogConfiguration
    
    public init(forConfiguration config: LogConfiguration) {
        self.config = config
        logLevelSymbols = config.logLevelSymbols
    }
    
    @discardableResult
    public func setError(_ error: String) -> LogLevelSymbolBuilder {
        logLevelSymbols.error = error
        return self
    }
    
    @discardableResult
    public func setWarning(_ warning: String) -> LogLevelSymbolBuilder {
        logLevelSymbols.warning = warning
        return self
    }
    
    @discardableResult
    public func setSuccess(_ success: String) -> LogLevelSymbolBuilder {
        logLevelSymbols.success = success
        return self
    }
    
    @discardableResult
    public func setAction(_ action: String) -> LogLevelSymbolBuilder {
        logLevelSymbols.action = action
        return self
    }
    
    @discardableResult
    public func setCanceled(_ canceled: String) -> LogLevelSymbolBuilder {
        logLevelSymbols.canceled = canceled
        return self
    }
    
    @discardableResult
    public func setOther(_ other: String) -> LogLevelSymbolBuilder {
        logLevelSymbols.other = other
        return self
    }
    
    @discardableResult
    public func buildAndReplace() -> LogLevelSymbols {
        config.replaceSymbols(with: logLevelSymbols)
        return logLevelSymbols
    }
    
    public func build() -> LogLevelSymbols {
        return logLevelSymbols
    }
}
