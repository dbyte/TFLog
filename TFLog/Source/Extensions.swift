//
//  Extensions.swift
//  TFLog
//
//  Created by Tammo on 15.01.20.
//  Copyright © 2020 dbyte. All rights reserved.
//

import Foundation

internal extension String {

    func removeExtraSpaces() -> String {
        return self.replacingOccurrences(of: "[^\\S\r\n]+", with: " ", options: .regularExpression, range: nil)
    }
}

internal extension Date {
    
    /// Converts given UTC date values ​​into an ISO8601 string of the given time zone.
    ///
    /// If the current time zone of the device is to be used, the timeZone parameter doesn't have to be passed.
    /// formatOptions not needed to be passed for standard ISO string.
    ///
    ///- parameters:
    ///     - timezone: Time zone (seen from UTC) into which the date values ​​are to be converted.
    ///     - formatOptions: One or more attributes of type ISO8601DateFormatter.Options,
    ///                      which determine the format of the ISO string.
    ///- returns:
    ///     - Without Param 'formatOptions': Full ISO8601 string including time zone information.
    ///     - With Param 'formatOptions': ISO format defined in passed parameter 'formatOptions'
    func convertToTimezoneISO8601(
        timeZone: TimeZone? = TimeZone.current,
        formatOptions: ISO8601DateFormatter.Options? = [.withTimeZone,
                                                        .withYear,
                                                        .withMonth,
                                                        .withDay,
                                                        .withTime,
                                                        .withDashSeparatorInDate,
                                                        .withColonSeparatorInTime,
                                                        .withColonSeparatorInTimeZone]
    ) -> String {
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.formatOptions = formatOptions!
        let timeZonedDateString = dateFormatter.string(from: self)
        return timeZonedDateString
    }
}
