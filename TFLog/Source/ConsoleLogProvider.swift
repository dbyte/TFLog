//
//  ConsoleLogProvider.swift
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

// MARK: Adapter for console

/// Adapter: Using internal console as log provider
internal class ConsoleLogProvider: LogProvider {
    
    // MARK: - Properties/Init
    
    private var message = ""
    private var category = ""
    
    internal init() {}
}

// MARK: - Private Methods

private extension ConsoleLogProvider {
    
    private func serialize(from logData: LogData) {
        self.message = logData.message
        self.category = logData.category
    }
}
    
// MARK: - Internal Methods

internal extension ConsoleLogProvider {
    
    /// Executes logging by printing to console.
    ///
    /// - Parameter setup: Data needed by the console to print the log.
    func executeLog(with logData: LogData) {
        serialize(from: logData)
        print("[\(category)] \(message)")
    }
}
