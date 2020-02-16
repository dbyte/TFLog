//
//  Logger.swift
//  TFLog
//
//  Created by Tammo on 15.01.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

public class LogConfiguration {
    
    // MARK: - Properties/Init
    
    private(set) var logLevelSymbols: LogLevelSymbols
    
    public init() {
        self.logLevelSymbols = LogLevelSymbols() // Set default log level symbols
    }
    
    // MARK: - Methods
    
    // External configuration: symbols can be built via LogLevelSymbolBuilder and then are injected here.
    public func changeSymbols(with symbols: LogLevelSymbols) {
        self.logLevelSymbols = symbols
    }

}

// MARK: - Logger Implementation

/// Logger Implementation
///
/// Wrapper for Swift.print. Provides simple logging functionality.
internal class Logger: LogInterface {
    
    // MARK: - Properties/Init
    
    private var header: String
    private var dataString: String
    private var timestampString: String
    private var logLevelSymbol: String
    private var option: Options?
    private var configuration: LogConfiguration
    
    internal init(configuration: LogConfiguration) {
        header = ""
        dataString = ""
        timestampString = ""
        logLevelSymbol = ""
        option = nil
        self.configuration = configuration
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
    func log(
        _ header: String? = "",
        data: Any? = nil,
        lev: LogLevel?) {
        
        #if CUSTOMLOG
        // Sanitize incoming values
        self.header = header?.trimmingCharacters(in: .whitespaces) ?? ""
        
        // Try casting data to string
        dataString = getDataString(data: data)
        
        // Get timestamp
        timestampString = getTimestampString()
        
        // Get emoticon for error cat
        logLevelSymbol = getLogLevelSymbol(lev: lev)
        
        // Output
        print(getFinalOutput())
        //print(file, function, finalOutput)
        #endif
    }
    
    func newLine() {
        #if CUSTOMLOG
        option = Options.newLine
        print(getFinalOutput())
        #endif
    }
    
    func verticalDivider() {
        #if CUSTOMLOG
        option = Options.verticalDivider
        print(getFinalOutput())
        #endif
    }
    
}

// MARK: - Private helpers

private extension Logger {
    
    private func getFinalOutput() -> String {
        var final: String
        
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
        
        switch option {
        case .newLine:
            final += "\n"
            
        case .verticalDivider:
            final += String(repeating: "-", count: 80)
            
        default:
            break
        }
        
        return final.removeExtraSpaces()
    }
    
    private func getDataString(data: Any?) -> String {
        guard let data = data else { return "" }
        return "▶️" + String(describing: data) + "◀️"
    }
    
    private func getLogLevelSymbol(lev: LogLevel?) -> String {
        return lev?.symbol(from: configuration.logLevelSymbols) ?? ""
    }
    
    private func getTimestampString() -> String {
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
