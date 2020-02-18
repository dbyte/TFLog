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
/// - See also: `LogConfiguration`, `LogLevelSymbolsInterface`
public protocol LogLevelSymbolBuildable {
    
    ///
    @discardableResult
    func setError(_ error: String) -> LogLevelSymbolBuildable
    
    ///
    @discardableResult
    func setWarning(_ warning: String) -> LogLevelSymbolBuildable
    
    ///
    @discardableResult
    func setSuccess(_ success: String) -> LogLevelSymbolBuildable
    
    ///
    @discardableResult
    func setAction(_ action: String) -> LogLevelSymbolBuildable
    
    ///
    @discardableResult
    func setCanceled(_ canceled: String) -> LogLevelSymbolBuildable
    
    ///
    @discardableResult
    func setOther(_ other: String) -> LogLevelSymbolBuildable
    
    ///
    @discardableResult
    func buildAndReplace() -> LogLevelSymbolsInterface
    
    ///
    @discardableResult
    func build() -> LogLevelSymbolsInterface
}

// MARK: - Builder for replacing log level unicode symbols

/// Log level unicode symbols customization.
internal final class LogLevelSymbolBuilder: LogLevelSymbolBuildable {
    
    private var logLevelSymbols: LogLevelSymbols
    private weak var config: LogConfiguration?
    
    init(forConfiguration config: LogConfiguration) {
        self.config = config
        logLevelSymbols = config.logLevelSymbols
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
