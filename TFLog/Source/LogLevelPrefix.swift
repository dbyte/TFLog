//
//  LogLevelPrefix.swift
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

// MARK: - Interface for LogLevelPrefix

/// Represents all provided log level unicode prefixes of this framework.
/// Log level unicode prefixes customization can be done via `LogConfigurable.replaceLogLevelPrefix()` .
/// - See also: `LogLevelPrefixBuilder`
public protocol LogLevelPrefixInterface {
    
    /// Error log level unicode prefix
    var error: String { get set }
    
    /// Warning log level unicode prefix
    var warning: String { get set }
    
    /// Success log level unicode prefix
    var success: String { get set }
    
    /// Action log level unicode prefix
    var action: String { get set }
    
    /// Canceled log level unicode prefix
    var canceled: String { get set }
    
    /// Other log level unicode prefix
    var other: String { get set }
}

// MARK: - Log level unicode prefixes

internal struct LogLevelPrefix: LogLevelPrefixInterface, Equatable {
    
    // MARK: Properties/Init
    
    internal var error: String
    internal var warning: String
    internal var success: String
    internal var action: String
    internal var canceled: String
    internal var other: String
    
    // Set default log level prefixes
    internal init() {
        self.error = "📕"
        self.warning = "📙"
        self.success = "📗"
        self.action = "📘"
        self.canceled = "📓"
        self.other = "📔"
    }
}
