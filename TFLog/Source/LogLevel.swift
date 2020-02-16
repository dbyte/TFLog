//
//  LogLevel.swift
//  TFLog
//
//  Created by Tammo on 15.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

/// Log levels
public enum LogLevel: String, CaseIterable {
    
    case error
    case warning
    case success
    case action
    case canceled
    case other
    
    internal func symbol(from currentSymbols: LogLevelSymbols) -> String {
        var symbol: String {
            
            switch self {
            case .error:
                return currentSymbols.error
                
            case .warning:
                return currentSymbols.warning
                
            case .success:
                return currentSymbols.success
                
            case .action:
                return currentSymbols.action
                
            case .canceled:
                return currentSymbols.canceled
                
            case .other:
                return currentSymbols.other
            }
        }
        return symbol
    }
}

/// Log level symbols customization hook
public struct LogLevelSymbols {
    
    internal var error: String
    internal var warning: String
    internal var success: String
    internal var action: String
    internal var canceled: String
    internal var other: String
    
    internal init() {
        self.error = "📕"
        self.warning = "📙"
        self.success = "📗"
        self.action = "📘"
        self.canceled = "📓"
        self.other = "📔"
    }
}

/// Log level symbols customization.
/// Use this builder to build a new set of symbols and inject it via LogConfiguration.changeSymbols(:)
public class LogLevelSymbolBuilder {
    
    internal var logLevelSymbols: LogLevelSymbols
    
    public init(forConfiguration config: LogConfiguration) {
        logLevelSymbols = config.logLevelSymbols
    }
    
    @discardableResult
    public func errorSymbol(_ error: String) -> LogLevelSymbolBuilder {
        logLevelSymbols.error = error
        return self
    }
    
    @discardableResult
    public func warningSymbol(_ warning: String) -> LogLevelSymbolBuilder {
        logLevelSymbols.warning = warning
        return self
    }
    
    @discardableResult
    public func successSymbol(_ success: String) -> LogLevelSymbolBuilder {
        logLevelSymbols.success = success
        return self
    }
    
    @discardableResult
    public func actionSymbol(_ action: String) -> LogLevelSymbolBuilder {
        logLevelSymbols.action = action
        return self
    }
    
    @discardableResult
    public func canceledSymbol(_ canceled: String) -> LogLevelSymbolBuilder {
        logLevelSymbols.canceled = canceled
        return self
    }
    
    @discardableResult
    public func otherSymbol(_ other: String) -> LogLevelSymbolBuilder {
        logLevelSymbols.other = other
        return self
    }
    
    public func build() -> LogLevelSymbols {
        return logLevelSymbols
    }
}
