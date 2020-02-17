//
//  LogAdapterForOSLog.swift
//  TFLog
//
//  Created by Tammo on 17.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import os.log

// MARK: Adapter for OSLog

/// Converting logger data and behaviour to the OSLog
internal class LogAdapterForOSLog {
    
    // MARK: - Properties/Init
    
    private var osLog = OSLog(subsystem: "", category: "")
    private var message = ""
    private var subsystem = ""
    private var category = ""
    private var type = OSLogType.default
    private var publicArg: StaticString = ""
    
    init() {}
}

// MARK: - Private Methods

private extension LogAdapterForOSLog {
    
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

internal extension LogAdapterForOSLog {
    
    /// Setup OSLog adapter to be prepared for logging.
    func setup(
        message: String? = nil,
        subsystem: String? = nil,
        category: String? = nil,
        lev: LogLevel? = nil,
        isPublic: Bool? = nil) {
        
        self.message = message ?? ""
        self.subsystem = adapt(subsystem: subsystem ?? "")
        self.category = adapt(category: category ?? "")
        self.type = adapt(logLevel: lev)
        self.publicArg = adapt(isPublic: isPublic ?? true)
        self.osLog = OSLog(subsystem: self.subsystem, category: self.category)
    }
    
    /// Executes logging.
    func log() {
        os_log(publicArg, log: osLog, type: type, message)
    }
}
