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
    
    // Convert log level
    private func adapt(logLevel: LogLevel?) -> OSLogType {
        switch logLevel {
        case .action:
            return OSLogType.info
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
            return OSLogType.info
        }
    }
    
    // Convert subsystem ID
    private func adapt(subsystem: String) -> String {
        if subsystem.isEmpty {
            return "com.dbyte.tflog"
        } else {
            return subsystem
        }
    }
    
    // Convert category
    private func adapt(category: String) -> String {
        if category.isEmpty {
            return "Common"
        } else {
            return category
        }
    }
    
    // Convert private/public data attribute
    private func adapt(isPublic: Bool) -> StaticString {
        if isPublic {
            return "%{PUBLIC}@" as StaticString
        } else {
            return "%{PRIVATE}@" as StaticString
        }
    }
}

// MARK: - Internal Methods

internal extension OSLogProvider {
    
    /// Setup OSLog adapter to be prepared for logging.
    func setup(
        message: String? = nil,
        subsystem: String? = nil,
        category: String? = nil,
        logLevel: LogLevel? = nil,
        isPublic: Bool? = nil) {
        
        self.message = message ?? ""
        self.subsystem = adapt(subsystem: subsystem ?? "")
        self.category = adapt(category: category ?? "")
        self.type = adapt(logLevel: logLevel)
        self.publicArg = adapt(isPublic: isPublic ?? true)
        self.osLog = OSLog(subsystem: self.subsystem, category: self.category)
    }
    
    /// Executes logging.
    func executeLog() {
        os_log(publicArg, log: osLog, type: type, message)
    }
}
