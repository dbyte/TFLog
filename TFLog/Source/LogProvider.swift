//
//  LogProvider.swift
//  TFLog
//
//  Created by Tammo on 18.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

 // MARK: - LogProvider

/// Protocol to which any log provider must subscribe to be usable by TFLog.
public protocol LogProvider {

    func executeLog()
    
    func setup(
        message: String?,
        subsystem: String?,
        category: String?,
        logLevel: LogLevel?,
        isPublic: Bool?)
}

 // MARK: - LogProvider Factory

/// Returning ready-for-use instances of different LogProviders.
open class LogProviderFactory {
    
    /// Returns a new default instance of OSLogProvider, conforming to LogProvider.
    public static func createOSLogProvider() -> LogProvider {
        return OSLogProvider()
    }
    
    /// Returns a new default instance of ConsoleLogProvider, conforming to LogProvider.
    public static func createConsoleProvider() -> LogProvider {
        return ConsoleLogProvider()
    }
}
