//
//  Logger.swift
//  TFLog
//
//  Created by Tammo on 15.01.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import Foundation

/// Model. Wrapper for Swift.print. Provides logging functionality.
internal class Logger {
    
    private var header: String
    private var dataString: String
    private var timestampString: String
    private var categoryEmoticon: String
    private var commonOpt: Option.Common?
    
    init() {
        header = ""
        dataString = ""
        timestampString = ""
        categoryEmoticon = ""
        commonOpt = nil
    }
    
    /// Print debug infos to console.
    ///
    /// - Parameters:
    ///     - header: Meaningful header for subsequent block of data.
    ///     - data: Describing data as text, f.i. for debugging additional info at runtime.
    internal func dump(
        _ header: String? = "",
        data: Any? = nil,
        cat: Option.Cat?,
        file: StaticString = #file,
        function: StaticString = #function) {
        
        // Sanitize incoming values
        self.header = header?.trimmingCharacters(in: .whitespaces) ?? ""
        
        // Try casting data to string
        dataString = getDataString(data: data)
        
        // Get timestamp
        timestampString = getTimestampString()
        
        // Get emoticon for error cat
        categoryEmoticon = getCategoryEmoticon(cat: cat)
        
        // Output
        print(getFinalOutput())
        //print(file, function, finalOutput)
    }
    
    internal func newLine() {
        commonOpt = Option.Common.newLine
        print(getFinalOutput())
    }
    
    internal func verticalDivider() {
        commonOpt = Option.Common.verticalDivider
        print(getFinalOutput())
    }
    
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
        
        switch commonOpt {
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
        return "➡️ " + String(describing: data) + " ◀️"
    }
    
    private func getCategoryEmoticon(cat: Option.Cat?) -> String {
        return cat?.rawValue ?? ""
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
