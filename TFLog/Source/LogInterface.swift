//
//  LogInterface.swift
//  TFLog
//
//  Created by Tammo on 15.01.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

// MARK: - Log API

/// Log Interface, logger implementations must conform to it.
public protocol LogInterface {
    /*
    Due to a swift protocol limitation concerning default values of function arguments,
    we need to permutate those arguments here. There are some other possibilites - however,
    we consider them as workarounds too.
    */
    
    /// Logging.
    ///
    /// - Parameters:
    ///     - header: Meaningful header for subsequent block of data.
    func log(_ header: String?)
    
    /// Logging.
    ///
    /// - Parameters:
    ///     - header: Meaningful header for subsequent block of data.
    ///     - data: Describing data as text, f.i. for debugging additional info at runtime.
    func log(_ header: String?, data: Any?)
    
    /// Logging.
    ///
    /// - Parameters:
    ///     - header: Meaningful header for subsequent block of data.
    ///     - lev: The log level.
    func log(_ header: String?, lev: LogLevel?)
    
    /// Logging.
    ///
    /// - Parameters:
    ///     - data: Describing data as text, f.i. for debugging additional info at runtime.
    func log(data: Any?)
    
    /// Logging.
    ///
    /// - Parameters:
    ///     - data: Describing data as text, f.i. for debugging additional info at runtime.
    ///     - lev: The log level.
    func log(data: Any?, lev: LogLevel?)
    
    /// Logging.
    ///
    /// - Parameters:
    ///     - header: Meaningful header for subsequent block of data.
    ///     - data: Describing data as text, f.i. for debugging additional info at runtime.
    ///     - lev: The log level.
    func log(_ header: String?, data: Any?, lev: LogLevel?)
    
    /// Logging: Add a linebreak below last line.
    func newLine()
    
    /// Logging: Add a vertical divider below last line.
    func verticalDivider()
}

// MARK: - Logging Strategy

/// Consumers must conform to this protocol to inherit its logging functionality.
public protocol Logging {
    
    /// Logger configuration. Falls back to default implemented logger settings if you don't provide
    /// your own settings in the conforming type.
    var loggerConfiguration: LogConfiguration { get }
    
    /// Encapsulates functionality of the logging utility.
    ///
    /// To change the default logger implementation for a certain type only, implement var directly
    /// in the using class and initialize with your concrete logger class.
    /// To switch the implementation for _all_ consumers, change the computed concrete logger in the
    /// extension of this protocol.
    var logger: LogInterface { get }
}

extension Logging {
    
    /// Sets the logger's default configuration if not overriden in the conforming type.
    public var loggerConfiguration: LogConfiguration { return LogConfiguration() }
    
    /// Encapsulates functionality of the logging utility.
    ///
    /// Its computation sets the default logger implementation (which in turn must conform to `LogInterface`).
    /// If consumers need some different implementation, change out the computed concrete logger here.
    public var logger: LogInterface { return Logger(configuration: loggerConfiguration) }

    /*
    Below code would also work, being very convenient, but causes all log methods to be
    first citizens in the consumers which would not conform to SRP:
     
    public func log(
        _ header: String? = "",
        data: Any? = nil,
        cat: Option.Cat? = nil,
        file: StaticString? = #file,
        function: StaticString? = #function) {
        
            logger.log(header, data: data, cat: cat)
        }
    */
}
