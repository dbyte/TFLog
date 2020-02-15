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
/// Wrapper for Swift.print. Provides simple logging functionality.
internal class Logger: LogInterface {
    
    // MARK: - Properties/Init
    
    private var header: String
    private var dataString: String
    private var timestampString: String
    private var categoryEmoticon: String
    private var option: Options?
    
    internal init() {
        header = ""
        dataString = ""
        timestampString = ""
        categoryEmoticon = ""
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
        categoryEmoticon = getCategoryEmoticon(lev: lev)
        
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
            final = timestampString + " " + categoryEmoticon + " " + header
            
        case let (header, dataString) where header.isEmpty && !dataString.isEmpty:
            // Only dataString is set, no header
            final = timestampString + " " + categoryEmoticon + "\n" + dataString
            
        case let (header, dataString) where !header.isEmpty && !dataString.isEmpty:
            // Both header and dataString are set
            final =  timestampString + " " + categoryEmoticon + " " + header + "\n" + dataString
            
        case let (header, dataString) where header.isEmpty && dataString.isEmpty && !categoryEmoticon.isEmpty:
            final = categoryEmoticon
            
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
    
    private func getCategoryEmoticon(lev: LogLevel?) -> String {
        return lev?.rawValue ?? ""
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
