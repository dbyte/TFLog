//
//  LogData.swift
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

public struct LogData {
    
    // MARK: - Properties/Init
    
    internal var message: String
    internal var data: Any?
    internal var subsystem: String
    internal var category: String
    internal var logLevel: LogLevel?
    internal var timestampStr: String
    internal var isPublic: Bool
    
    internal init(
        message: String?,
        data: Any?,
        subsystem: String?,
        category: String?,
        logLevel: LogLevel?,
        timestampStr: String?,
        isPublic: Bool?) {
        
        self.message = message ?? ""
        self.data = data
        self.subsystem = subsystem ?? ""
        self.category = category ?? ""
        self.logLevel = logLevel
        self.timestampStr = timestampStr ?? ""
        self.isPublic = isPublic ?? true
    }
    
    internal init() {
        self.init(
            message: nil,
            data: nil,
            subsystem: nil,
            category: nil,
            logLevel: nil,
            timestampStr: nil,
            isPublic: nil
        )
    }
}
