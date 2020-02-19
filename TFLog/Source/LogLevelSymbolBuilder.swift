//
//  LogLevelSymbolBuilder.swift
//  TFLog
//
//  Created by Tammo on 18.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

// MARK: - Interface for LogLevelSymbolBuilder

/// Log level unicode symbols customization.
///
/// Use this builder to create a new set of symbols or just set the ones you want to overwrite.
/// - See also: `LogConfigurable`, `LogLevelSymbolsInterface`
public protocol LogLevelSymbolBuildable {
    
    /// Set _error_ prefix
    /// - Parameter error: Sets a prefix for log level _error_ in form of unicode symbol or text
    @discardableResult
    func setError(_ error: String) -> LogLevelSymbolBuildable
    
    /// Set _warning_ prefix
    /// - Parameter warning: Sets a prefix for log level _warning_ in form of unicode symbol or text
    @discardableResult
    func setWarning(_ warning: String) -> LogLevelSymbolBuildable
    
    /// Set _success_ prefix
    /// - Parameter success: Sets a prefix for log level _success_ in form of unicode symbol or text
    @discardableResult
    func setSuccess(_ success: String) -> LogLevelSymbolBuildable
    
    /// Set _action_ prefix
    /// - Parameter action: Sets a prefix for log level _action_ in form of unicode symbol or text
    @discardableResult
    func setAction(_ action: String) -> LogLevelSymbolBuildable
    
    /// Set _canceled_ prefix
    /// - Parameter canceled: Sets a prefix for log level _canceled_ in form of unicode symbol or text
    @discardableResult
    func setCanceled(_ canceled: String) -> LogLevelSymbolBuildable
    
    /// Set _other_ prefix
    /// - Parameter other: Sets a prefix for log level _other_ in form of unicode symbol or text
    @discardableResult
    func setOther(_ other: String) -> LogLevelSymbolBuildable
    
    ///
    @discardableResult
    func buildAndReplace() -> LogLevelSymbolsInterface
    
    ///
    @discardableResult
    func build() -> LogLevelSymbolsInterface
}

// MARK: - Builder implementation for replacing log level unicode symbols

/// Log level unicode symbols customization.
internal final class LogLevelSymbolBuilder: LogLevelSymbolBuildable {
    
    private var logLevelSymbols: LogLevelSymbolsInterface
    private var config: LogConfigurable?
    
    init(forConfiguration config: LogConfigurable) {
        self.config = config
        logLevelSymbols = config.getLogLevelSymbols()
    }
    
    func setError(_ error: String) -> LogLevelSymbolBuildable {
        logLevelSymbols.error = error
        return self
    }
    
    func setWarning(_ warning: String) -> LogLevelSymbolBuildable {
        logLevelSymbols.warning = warning
        return self
    }
    
    func setSuccess(_ success: String) -> LogLevelSymbolBuildable {
        logLevelSymbols.success = success
        return self
    }
    
    func setAction(_ action: String) -> LogLevelSymbolBuildable {
        logLevelSymbols.action = action
        return self
    }
    
    func setCanceled(_ canceled: String) -> LogLevelSymbolBuildable {
        logLevelSymbols.canceled = canceled
        return self
    }
    
    func setOther(_ other: String) -> LogLevelSymbolBuildable {
        logLevelSymbols.other = other
        return self
    }
    
    func buildAndReplace() -> LogLevelSymbolsInterface {
        config?.replaceSymbols(with: logLevelSymbols)
        return logLevelSymbols
    }
    
    func build() -> LogLevelSymbolsInterface {
        return logLevelSymbols
    }
}
