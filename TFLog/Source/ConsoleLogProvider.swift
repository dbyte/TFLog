//
//  ConsoleLogProvider.swift
//  TFLog
//
//  Created by Tammo on 18.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

// MARK: Adapter for console

/// Adapter: Using internal console as log provider
internal class ConsoleLogProvider: LogProvider {
    
    // MARK: - Properties/Init
    
    private var message: String?
    private var subsystem: String?
    private var category: String?
    private var logLevel: LogLevel?
    private var isPublic: Bool?
    
    public init() {}
}
    
    // MARK: - Internal Methods

internal extension ConsoleLogProvider {
    
    func executeLog() {
        let category = self.category ?? ""
        let message = self.message ?? ""
        print("[\(category)] \(message)")
    }
    
    func setup(
        message: String?,
        subsystem: String?,
        category: String?,
        logLevel: LogLevel?,
        isPublic: Bool?) {
        
        self.message = message
        self.subsystem = subsystem
        self.category = category
        self.logLevel = logLevel
        self.isPublic = isPublic
    }
}
