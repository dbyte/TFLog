//
//  LoggerFactory.swift
//  TFLog
//
//  Created by Tammo on 18.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

// MARK: - Logger Factory

/// Produces ready-for-use instances of class Logger.
public class LoggerFactory {
    
    /// Returns a new Logger which conforms to LogInterface.
    public static func createLogger(configuration: LogConfigurable, category: String) -> LogInterface {
        return Logger(configuration: configuration, category: category)
    }
    
    /// Returns a new LogConfiguration which conforms to LogConfigurable.
    public static func createLogConfiguration() -> LogConfigurable {
        return LogConfiguration()
    }
}
