//
//  LogLevelSymbols.swift
//  TFLog
//
//  Created by Tammo on 16.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

// MARK: - Interface for LogLevelSymbols

/// Represents all provided log level unicode symbols of this framework.
/// Log level unicode symbols customization can be done via `LogConfigurable.replaceLogLevelSymbols()` .
/// - See also: `LogLevelSymbolBuilder`
public protocol LogLevelSymbolsInterface {
    
    /// Error log level unicode symbol
    var error: String { get set }
    
    /// Warning log level unicode symbol
    var warning: String { get set }
    
    /// Success log level unicode symbol
    var success: String { get set }
    
    /// Action log level unicode symbol
    var action: String { get set }
    
    /// Canceled log level unicode symbol
    var canceled: String { get set }
    
    /// Other log level unicode symbol
    var other: String { get set }
}

// MARK: - Log level unicode symbols

internal struct LogLevelSymbols: LogLevelSymbolsInterface, Equatable {
    
    // MARK: Properties/Init
    
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
