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
    
    /// Required to configure the logger.
    init(configuration: LogConfiguration, category: String)
    
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
    
    /// Injects a logger configuration into a existing logger object.
    func configure(with configuration: LogConfiguration)
    
    /// Gets current logger configuration object.
    func getConfiguration() -> LogConfiguration
}

// MARK: - Logging Strategy

/// Consumers must conform to this protocol to inherit its logging functionality.
/// There are different ways to get the logger working in your module.
///
/// 1. To get default logging functionalities right away, just conform your types to this protocol.
///
/// 2. If you need one custom configuration for your whole module, you would conform to this protocol
/// in a new protocol which then defines/sets the `logger` variable and does some configuration on it.
///
/// 3. If you need a special configuration within a single type which conforms to `Logging`, you just
/// place the definition `var logger: Logging` inside that type. That will actually override
/// the default computed value in the protocol's extension. Configure it with the values of your needs.
public protocol Logging {
    
    /// Encapsulates functionality of the logging utility.
    /// `logger` computation sets the default logger implementation (which in turn must conform to `LogInterface`).
    /// If consumers need some different implementation, change out the computed concrete logger
    /// by inheriting from this protocol in a new protocol.
    ///
    /// To change the default logger implementation for a certain type only, implement `logger` var directly
    /// in the consuming class/struct and initialize with your custom logger object.
    /// To switch the implementation for _all_ consumers, change the computation of the concrete logger in the
    /// extension of this protocol by inheriting from it in a new protocol.
    var logger: LogInterface { get }
    
    /// The log category. Will be adapted to OSLog `Category` when using OSLog.
    ///
    /// The default computation sets this var to the consumer's type name.
    /// To set a custom category, implement `logCategory` var directly in your consuming class/struct
    /// and set it to a value of your needs while initializing.
    var logCategory: String { get }
    
    static func logCreateLogger(configuration: LogConfiguration, category: String) -> LogInterface
}

extension Logging {
    
    /// Encapsulates functionality of the logging utility for a consumer of this interface.
    internal var logger: LogInterface { return Logger(configuration: LogConfiguration(), category: logCategory) }
    
    /// The log category.
    public var logCategory: String { return "\(Self.self)" }
    
    public static func logCreateLogger(configuration: LogConfiguration, category: String) -> LogInterface {
        Logger(configuration: configuration, category: category) as LogInterface
    }
}
