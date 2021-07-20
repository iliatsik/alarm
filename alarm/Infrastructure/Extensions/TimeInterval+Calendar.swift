//
//  TimeInterval.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 19.07.21.
//

import UIKit

extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}

extension Calendar {

    func dateBySetting(timeZone: TimeZone, of date: Date) -> Date? {
        var components = dateComponents(in: self.timeZone, from: date)
        components.timeZone = timeZone
        return self.date(from: components)
    }

    func dateBySettingTimeFrom(timeZone: TimeZone, of date: Date) -> Date? {
        var components = dateComponents(in: timeZone, from: date)
        components.timeZone = self.timeZone
        return self.date(from: components)
    }
}

