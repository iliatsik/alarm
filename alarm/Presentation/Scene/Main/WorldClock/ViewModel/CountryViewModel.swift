//
//  CountryViewModel.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import Foundation

struct CountryViewModel {
    
    private var country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var name: String {
        country.name ?? ""
    }
    
    var region: String {
        country.region ?? ""
    }
    
    var capital: String {
        var capital = "\(String(describing: country.capital!))"
        if capital == "" {
            capital = "\(String(describing: country.name!))"
        }
        return capital
    }
    
    var exactTime: String {
        let initTz = TimeZone(abbreviation: "GMT+4")!
        let targetTz = TimeZone(abbreviation: country.timezones?[0] ?? "UTC+03:00")!
        let initDate = Date()
        
        var calendar = Calendar.current
        calendar.timeZone = initTz
        let case1TargetDate = calendar.dateBySetting(timeZone: targetTz, of: initDate)!
        let case2TargetDate = calendar.dateBySettingTimeFrom(timeZone: targetTz, of: initDate)!

        let formatter = ISO8601DateFormatter()

        formatter.formatOptions = [ .withFullTime ]
        
//      formatter.timeZone = targetTz
       
        formatter.timeZone = initTz

        let index = formatter.string(from: case2TargetDate).index(formatter.string(from: case1TargetDate).startIndex, offsetBy: 5)

        return String(formatter.string(from: case2TargetDate).prefix(upTo: index))
    }
 
    var time : String {
        var time = (country.timezones ?? ["UTC+02:00"])[0]
        if country.timezones![0] == "UTC" {
            time = "UTC+00:00"
        }
        return "\(time)"
    }
  
}



