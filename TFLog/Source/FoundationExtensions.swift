//
//  FoundationExtensions.swift
//  TFLog
//
//  Created by Tammo on 15.01.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import Foundation

// MARK: - String Extensions

internal extension String {

    func removeExtraSpaces() -> String {
        return self.replacingOccurrences(of: "[^\\S\r\n]+", with: " ", options: .regularExpression, range: nil)
    }
}
