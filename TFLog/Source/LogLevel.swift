//
//  LogLevel.swift
//  TFLog
//
//  Created by Tammo on 15.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

// MARK: Fixed log levels and their corresponding (unicode-) symbols

/// Provided log levels.
///
/// You can replace the unicode symbols by using `LogConfigurable.replaceLogLevelSymbols()` .
/// - See also: `LogLevelSymbolBuilder`
public enum LogLevel: String, CaseIterable {
    
    case error
    case warning
    case success
    case action
    case canceled
    case other
    
    // It's possible for consumers to replace the corresponding unicode symbols.
    internal func getSymbol(from symbols: LogLevelSymbolsInterface) -> String {
        var symbol: String {
            
            switch self {
            case .error:
                return symbols.error
                
            case .warning:
                return symbols.warning
                
            case .success:
                return symbols.success
                
            case .action:
                return symbols.action
                
            case .canceled:
                return symbols.canceled
                
            case .other:
                return symbols.other
            }
        }
        return symbol
    }
}
