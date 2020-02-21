//
//  LogProvider.swift
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

// MARK: - LogProvider

/// Protocol to which any log provider must subscribe to be usable by TFLog.
public protocol LogProvider {

    /// Finally executes logging with configured LogProvider.
    ///
    /// - Parameter logData: The data needed by the LogProvider to execute the log.
    func executeLog(with logData: LogData)
}

// MARK: - LogProvider Factory

/// Returning ready-for-use instances of different LogProviders.
open class LogProviderFactory {
    
    /// Returns a new default instance of OSLogProvider, conforming to LogProvider.
    open class func createOSLogProvider() -> LogProvider {
        return OSLogProvider()
    }
    
    /// Returns a new default instance of ConsoleLogProvider, conforming to LogProvider.
    open class func createConsoleProvider() -> LogProvider {
        return ConsoleLogProvider()
    }
}
