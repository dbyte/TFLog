//
//  Logger.swift
//  TFLog
//
//  Created by Tammo on 15.01.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

// MARK: - Logger Implementation

/// Logger Implementation
///
/// Main Logger. Provides logging functionality by using a logging provider such as OSLog or Console.
internal class Logger: LogInterface {    
    
    // MARK: - Properties/Init
    
    private var configuration: LogConfigurable
    private var category: String
    private var header: String
    private var dataString: String
    private var timestampString: String
    private var logLevelSymbol: String
    private var option: Options?
    
    internal required init(configuration: LogConfigurable, category: String) {
        self.configuration = configuration
        self.category = category
        header = ""
        dataString = ""
        timestampString = ""
        logLevelSymbol = ""
        option = nil
    }
}

// MARK: - Methods

internal extension Logger {
    
    func log(_ header: String?) {
        log(header, data: nil, lev: nil)
    }
    
    func log(_ header: String?, data: Any?) {
        log(header, data: data, lev: nil)
    }
    
    func log(_ header: String?, lev: LogLevel?) {
        log(header, data: nil, lev: lev)
    }
    
    func log(data: Any?) {
        log(nil, data: data, lev: nil)
    }
    
    func log(data: Any?, lev: LogLevel?) {
        log(nil, data: data, lev: lev)
    }
    
    // Print debug infos to console.
    func log(_ header: String? = "", data: Any? = nil, lev: LogLevel?) {
        
        #if CUSTOMLOG
        // Early return when switched off via configuration.
        guard configuration.getIsLoggingActive() else { return }
        
        // Sanitize incoming values
        self.header = header?.trimmingCharacters(in: .whitespaces) ?? ""
        
        // Try casting data to string
        dataString = getDataString(data: data)
        
        // Get timestamp
        timestampString = getTimestampString()
        
        // Get emoticon for error cat
        logLevelSymbol = getLogLevelSymbol(lev: lev)
        
        // Output
        execute(logLevel: lev)
        #endif
    }
    
    func newLine() {
        #if CUSTOMLOG
        // Early return when switched off via configuration.
        guard configuration.getIsLoggingActive() else { return }
        
        option = Options.newLine
        
        execute()
        #endif
    }
    
    func verticalDivider() {
        #if CUSTOMLOG
        // Early return when logging was switched off via configuration.
        guard configuration.getIsLoggingActive() else { return }
        
        option = Options.verticalDivider
        
        execute()
        #endif
    }
    
    func configure(with configuration: LogConfigurable) {
        self.configuration = configuration
    }
    
    func getConfiguration() -> LogConfigurable {
        return configuration
    }
    
}

// MARK: - Private helpers

private extension Logger {
    
    private func execute(logLevel: LogLevel? = nil) {
        let provider = configuration.getLogProvider()
        
        provider.setup(
            message: getFinalOutput(),
            subsystem: configuration.getSubsystemID(),
            category: category,
            logLevel: logLevel,
            isPublic: true)
        
        provider.executeLog()
    }
    
    private func getFinalOutput() -> String {
        var final: String
        
        // Log handling
        
        switch(header, dataString) {
        case let (header, dataString) where !header.isEmpty && dataString.isEmpty:
            // Only "header" parameter is set, no data
            final = timestampString + " " + logLevelSymbol + " " + header
            
        case let (header, dataString) where header.isEmpty && !dataString.isEmpty:
            // Only dataString is set, no header
            final = timestampString + " " + logLevelSymbol + "\n" + dataString
            
        case let (header, dataString) where !header.isEmpty && !dataString.isEmpty:
            // Both header and dataString are set
            final =  timestampString + " " + logLevelSymbol + " " + header + "\n" + dataString
            
        case let (header, dataString) where header.isEmpty && dataString.isEmpty && !logLevelSymbol.isEmpty:
            final = logLevelSymbol
            
        default:
            final = ""
        }
        
        // Option handling
        
        switch option {
        case .newLine:
            final += "\n"
            
        case .verticalDivider:
            final += String(repeating: "-", count: 80)
            
        default:
            break
        }
        
        // Result
        
        return final.removeExtraSpaces()
    }
    
    private func getDataString(data: Any?) -> String {
        guard let data = data else { return "" }
        return "▶️" + String(describing: data) + "◀️"
    }
    
    private func getLogLevelSymbol(lev: LogLevel?) -> String {
        return lev?.symbol(from: configuration.getLogLevelSymbols()) ?? ""
    }
    
    private func getTimestampString() -> String {
        guard configuration.getIsTimestampIncluded() else { return "" }
        let formatOptions: ISO8601DateFormatter.Options =
            [.withYear,
             .withMonth,
             .withDay,
             .withFullTime,
             .withDashSeparatorInDate,
             .withColonSeparatorInTime]
        let result = Date().convertToTimezoneISO8601(timeZone: TimeZone.current, formatOptions: formatOptions)
        return result
    }
}
