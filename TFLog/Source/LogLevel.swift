//
//  LogLevel.swift
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

// MARK: Fixed log levels and their corresponding (unicode-) prefixes

/// Provided log levels.
///
/// You can replace the unicode prefixes by using `LogConfigurable.replaceLogLevelPrefixes()` .
/// - See also: `LogLevelPrefixBuilder`
public enum LogLevel: String, CaseIterable {
    
    case error
    case warning
    case success
    case action
    case canceled
    case other
    
    // It's possible for consumers to replace the corresponding unicode prefixes.
    internal func getPrefix(from prefixes: LogLevelPrefixInterface) -> String {
        var prefix: String {
            
            switch self {
            case .error:
                return prefixes.error
                
            case .warning:
                return prefixes.warning
                
            case .success:
                return prefixes.success
                
            case .action:
                return prefixes.action
                
            case .canceled:
                return prefixes.canceled
                
            case .other:
                return prefixes.other
            }
        }
        return prefix
    }
}
