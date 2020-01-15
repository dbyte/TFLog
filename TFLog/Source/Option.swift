//
//  Option.swift
//  TFLog
//
//  Created by Tammo on 15.01.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import Foundation

public struct Option {
    
    public enum Cat: String {
        
        case error = "📕"
        case warning = "📙"
        case success = "📗"
        case action = "📘"
        case canceled = "📓"
        case other = "📔"
    }

    internal enum Common {
        
        case newLine
        case verticalDivider
    }
}
