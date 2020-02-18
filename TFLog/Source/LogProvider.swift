//
//  LogProvider.swift
//  TFLog
//
//  Created by Tammo on 18.02.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

/// Protocol to which any log provider must subscribe to be usable by TFLog.
public protocol LogProvider {

    func executeLog()
    
    func setup(
        message: String?,
        subsystem: String?,
        category: String?,
        logLevel: LogLevel?,
        isPublic: Bool?)
}
