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

// MARK: Fixed log levels and their corresponding (unicode-) symbols

/// Provided log levels.
///
/// You can replace the unicode symbols by using `LogConfigurable.replaceLogLevelSymbols()` .
/// - See also: `LogLevelPrefixBuilder`
public enum LogLevel: String, CaseIterable {
    
    case error
    case warning
    case success
    case action
    case canceled
    case other
    
    // It's possible for consumers to replace the corresponding unicode symbols.
    internal func getSymbol(from symbols: LogLevelPrefixInterface) -> String {
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
