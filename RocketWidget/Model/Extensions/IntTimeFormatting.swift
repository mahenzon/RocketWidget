//
//  IntTimeFormatting.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 01.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Foundation

extension Int {

    func getFormatter(_ format: DateFormattersStyle) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        switch format {
        case .short:
            dateFormatter.dateFormat = "HH:mm, dd.MM.yyyy"
        case .medium:
            dateFormatter.dateFormat = "HH:mm, dd MMMM yyyy"
        }
        return dateFormatter
    }

    var timeFormatting: String {
        return getFormatter(.short).string(from: Date(timeIntervalSince1970: Double(self)))
    }
    var mediumTimeFormatting: String {
        return getFormatter(.medium).string(from: Date(timeIntervalSince1970: Double(self)))
    }
}
