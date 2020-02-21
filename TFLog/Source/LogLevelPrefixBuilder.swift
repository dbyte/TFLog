//
//  LogLevelPrefixBuilder.swift
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

// MARK: - Interface for LogLevelPrefixBuilder

/// Log level unicode prefixes customization.
///
/// Use this builder to create a new set of prefixes or just set the ones you want to overwrite.
/// - See also: `LogConfigurable`, `LogLevelPrefixInterface`
public protocol LogLevelPrefixBuildable {
    
    /// Set _error_ prefix
    /// - Parameter error: Sets a prefix for log level _error_ in form of unicode prefix or text
    @discardableResult
    func setError(_ error: String) -> LogLevelPrefixBuildable
    
    /// Set _warning_ prefix
    /// - Parameter warning: Sets a prefix for log level _warning_ in form of unicode prefix or text
    @discardableResult
    func setWarning(_ warning: String) -> LogLevelPrefixBuildable
    
    /// Set _success_ prefix
    /// - Parameter success: Sets a prefix for log level _success_ in form of unicode prefix or text
    @discardableResult
    func setSuccess(_ success: String) -> LogLevelPrefixBuildable
    
    /// Set _action_ prefix
    /// - Parameter action: Sets a prefix for log level _action_ in form of unicode prefix or text
    @discardableResult
    func setAction(_ action: String) -> LogLevelPrefixBuildable
    
    /// Set _canceled_ prefix
    /// - Parameter canceled: Sets a prefix for log level _canceled_ in form of unicode prefix or text
    @discardableResult
    func setCanceled(_ canceled: String) -> LogLevelPrefixBuildable
    
    /// Set _other_ prefix
    /// - Parameter other: Sets a prefix for log level _other_ in form of unicode prefix or text
    @discardableResult
    func setOther(_ other: String) -> LogLevelPrefixBuildable
    
    ///
    @discardableResult
    func buildAndReplace() -> LogLevelPrefixInterface
    
    ///
    @discardableResult
    func build() -> LogLevelPrefixInterface
}

// MARK: - Builder implementation for replacing log level unicode prefixes

/// Log level unicode prefixes customization.
internal final class LogLevelPrefixBuilder: LogLevelPrefixBuildable {
    
    private var logLevelPrefix: LogLevelPrefixInterface
    private var config: LogConfigurable?
    
    init(forConfiguration config: LogConfigurable) {
        self.config = config
        logLevelPrefix = config.getLogLevelPrefixes()
    }
    
    func setError(_ error: String) -> LogLevelPrefixBuildable {
        logLevelPrefix.error = error
        return self
    }
    
    func setWarning(_ warning: String) -> LogLevelPrefixBuildable {
        logLevelPrefix.warning = warning
        return self
    }
    
    func setSuccess(_ success: String) -> LogLevelPrefixBuildable {
        logLevelPrefix.success = success
        return self
    }
    
    func setAction(_ action: String) -> LogLevelPrefixBuildable {
        logLevelPrefix.action = action
        return self
    }
    
    func setCanceled(_ canceled: String) -> LogLevelPrefixBuildable {
        logLevelPrefix.canceled = canceled
        return self
    }
    
    func setOther(_ other: String) -> LogLevelPrefixBuildable {
        logLevelPrefix.other = other
        return self
    }
    
    func buildAndReplace() -> LogLevelPrefixInterface {
        config?.replacePrefixes(with: logLevelPrefix)
        return logLevelPrefix
    }
    
    func build() -> LogLevelPrefixInterface {
        return logLevelPrefix
    }
}
