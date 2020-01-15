//
//  API.swift
//  TFLog
//
//  Created by Tammo on 15.01.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

/// Log API
public struct Log {
    
    internal init() {}
    
    public static func dump(
        _ header: String? = "",
        data: Any? = nil,
        cat: Option.Cat? = nil,
        file: StaticString = #file,
        function: StaticString = #function) {
        
        #if CUSTOMLOG
        // We must instantiate the logger, taking care of multithreading!
        let logger = Logger()
        logger.dump(header, data: data, cat: cat, file: file, function: function)
        #endif
    }
    
    public static func newLine() {
        // We must instantiate the logger, taking care of multithreading!
        #if CUSTOMLOG
        let logger = Logger()
        logger.newLine()
        #endif
    }
    
    public static func verticalDivider() {
        // We must instantiate the logger, taking care of multithreading!
        #if CUSTOMLOG
        let logger = Logger()
        logger.verticalDivider()
        #endif
    }

}
