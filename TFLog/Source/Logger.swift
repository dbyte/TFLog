//
//  Logger.swift
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

import Foundation

// MARK: - Logger Implementation

/// Logger Implementation
///
/// Main Logger. Provides logging functionality by using a logging provider such as OSLog or Console.
internal class Logger: LogInterface {    
    
    // MARK: Properties/Init
    
    private var configuration: LogConfigurable
    private var logData: LogData
    private var option: Options?
    
    internal required init(configuration: LogConfigurable, category: String) {
        self.configuration = configuration
        self.logData = LogData()
        self.logData.category = category
        self.logData.subsystem = configuration.getSubsystemID()
        self.logData.isPublic = true // TODO
        option = nil
    }
}

// MARK: Methods

internal extension Logger {
    
    // MARK: - Conforming to protocol LogInterface
    
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
    
    // Main log behaviour.
    func log(_ header: String? = "", data: Any? = nil, lev: LogLevel?) {
        
        #if DEBUG
        // Run core logging in background thread.
        // Note: Tried for weak/unowned self capturing here, but won't work: self gets lost.
        // Did init/deinit tests by manually counting instances up & down; seems there is no memory leak (v1.0.0).
        DispatchQueue.global(qos: .background).async {
            
            // Early return when switched off via configuration.
            guard self.configuration.getIsLoggingActive() else { return }
            
            // Trim and set incoming string
            self.logData.message = header?.trimmingCharacters(in: .whitespaces) ?? ""
            
            // Set any additional incoming data
            self.logData.data = data
            
            // Set timestamp
            self.logData.timestampStr = self.getTimestampString()
            
            // Set emoticon for error cat
            self.logData.logLevel = lev
            
            // Output
            self.execute()
        }
        #endif
    }
    
    // MARK: Special option: make new line
    
    func newLine() {
        #if DEBUG
        // Early return when switched off via configuration.
        guard configuration.getIsLoggingActive() else { return }
        
        option = Options.newLine
        
        execute()
        #endif
    }
    
    // MARK: Special option: make vertical divider
    
    func verticalDivider() {
        #if DEBUG
        // Early return when logging was switched off via configuration.
        guard configuration.getIsLoggingActive() else { return }
        
        option = Options.verticalDivider
        
        execute()
        #endif
    }
    
    // MARK: Configuration accsessors
    
    func setConfiguration(with configuration: LogConfigurable) {
        self.configuration = configuration
    }
    
    func getConfiguration() -> LogConfigurable {
        return configuration
    }
    
}

// MARK: - Private helpers

private extension Logger {
    
    private func execute() {
        // Compose final message
        logData.message = getComposedMessage()
        
        let provider = configuration.getLogProvider()
        provider.executeLog(with: logData)
    }
    
    private func getComposedMessage() -> String {
        
        // MARK: Compose log message text
        
        var final: String
        
        let header = logData.message
        
        let dataString = getDataString(data: logData.data) // try casting data to string, returns empty string on fail
        
        let timestampStringAndWhitespace = configuration.getIsTimestampIncluded() ? logData.timestampStr + " " : ""
        
        let logLevelPrefix = getLogLevelPrefix(lev: logData.logLevel)
        let logLevelPrefixAndNewline = logLevelPrefix.isEmpty ? "" : logLevelPrefix + "\n"
        let logLevelPrefixAndWhitespace = logLevelPrefix.isEmpty ? "" : logLevelPrefix + " "
        
        switch(header, dataString) {
        case let (header, dataString) where !header.isEmpty && dataString.isEmpty:
            // Only "header" parameter is set, no data
            final = timestampStringAndWhitespace + logLevelPrefixAndWhitespace + header
            
        case let (header, dataString) where header.isEmpty && !dataString.isEmpty:
            // Only dataString is set, no header
            final = timestampStringAndWhitespace + logLevelPrefixAndNewline + dataString
            
        case let (header, dataString) where !header.isEmpty && !dataString.isEmpty:
            // Both header and dataString are set
            final = timestampStringAndWhitespace + logLevelPrefixAndWhitespace + header + "\n" + dataString
            
        case let (header, dataString) where header.isEmpty && dataString.isEmpty && !logLevelPrefix.isEmpty:
            // This case isn't part of protocol LogInterface yet (v1.0.0). Anyway doesn't hurt to
            // keep it, though it can't be tested yet.
            final = logLevelPrefix
            
        default:
            final = ""
        }
        
        // MARK: Option handling
        
        switch option {
        case .newLine:
            final += "\n"
            
        case .verticalDivider:
            final += String(repeating: "-", count: 80)
            
        default:
            break
        }
        
        // MARK: Result
        
        return final.removeExtraSpaces()
    }
    
    // MARK: -
    
    private func getDataString(data: Any?) -> String {
        guard let data = data else { return "" }
        return "▶️" + String(describing: data) + "◀️"
    }
    
    private func getLogLevelPrefix(lev: LogLevel?) -> String {
        return lev?.getPrefix(from: configuration.getLogLevelPrefix()) ?? ""
    }
    
    private func getTimestampString() -> String {
        guard configuration.getIsTimestampIncluded() else { return "" }
        
        let formatOptions: ISO8601DateFormatter.Options =
            [.withYear,
             .withMonth,
             .withDay,
             .withFullTime,
             .withDashSeparatorInDate,
             .withColonSeparatorInTime,
             .withTimeZone]
        
        let result = ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: formatOptions)
        return result
    }
}
