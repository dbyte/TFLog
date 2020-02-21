//
//  OSLogProvider.swift
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

import os.log

// MARK: Adapter for OSLog

/// Adapter: Using OSLog infrastructure
internal class OSLogProvider: LogProvider {
    
    // MARK: - Properties/Init
    
    private var osLog = OSLog(subsystem: "", category: "")
    private var message = ""
    private var subsystem = ""
    private var category = ""
    private var type = OSLogType.default
    private var publicArg: StaticString = ""
    
    internal init() {}
}

// MARK: - Private Methods

private extension OSLogProvider {
    
    private func serialize(from logData: LogData) {
        self.message = logData.message
        self.subsystem = adapt(subsystem: logData.subsystem)
        self.category = adapt(category: logData.category)
        self.type = adapt(logLevel: logData.logLevel)
        self.publicArg = adapt(isPublic: logData.isPublic)
        self.osLog = OSLog(subsystem: self.subsystem, category: self.category)
    }
    
    // Convert log level
    private func adapt(logLevel: LogLevel?) -> OSLogType {
        switch logLevel {
        case .action:
            return OSLogType.info // OSLogType.debug inop?
        case .canceled:
            return OSLogType.info
        case .error:
            return OSLogType.fault
        case .other:
            return OSLogType.info
        case .success:
            return OSLogType.info
        case .warning:
            return OSLogType.error
        default:
            return OSLogType.info // OSLogType.debug inop?
        }
    }
    
    // Convert subsystem ID
    private func adapt(subsystem: String) -> String {
        if subsystem.isEmpty {
            return "com.dbyte.tflog"
        }
        return subsystem
    }
    
    // Convert category
    private func adapt(category: String) -> String {
        if category.isEmpty {
            return "Common"
        }
        return category
    }
    
    // Convert private/public data attribute
    private func adapt(isPublic: Bool) -> StaticString {
        if isPublic {
            return "%{PUBLIC}@" as StaticString
        }
        return "%{PRIVATE}@" as StaticString
    }
}

// MARK: - Internal Methods

internal extension OSLogProvider {
    
    /// Executes logging.
    /// - Parameter logData: The data needed by OSLog to execute the log.
    func executeLog(with logData: LogData) {
        serialize(from: logData)
        os_log(publicArg, log: osLog, type: type, message)
    }
}
