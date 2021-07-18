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
        "\(country.capital ?? "\(country.name)")"
    }
    
    var exactTime: String {
        let currentDate = Date()
        let format = DateFormatter()
        format.timeZone = TimeZone(abbreviation: "UTC") //"\(country.timezones)")//.current
        format.dateFormat = "HH:mm"
        let dateString = format.string(from: currentDate)
        
        return dateString
    }

 
    var time : String {
        let time = (country.timezones ?? ["00:00"])[0]
        return "\(time)"
    }
}


extension Date {
   struct Formatter {
       static let utcFormatter: DateFormatter = {
           let dateFormatter = DateFormatter()
 
           dateFormatter.dateFormat = "mm:ss'Z'"
           dateFormatter.timeZone = TimeZone(identifier: "UTC")
 
           return dateFormatter
       }()
   }
 
   var dateToUTC: String {
       return Formatter.utcFormatter.string(from: self)
   }
}
 
extension String {
   struct Formatter {
       static let utcFormatter: DateFormatter = {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "HH:mm:ssz"
           
           return dateFormatter
       }()
   }
 
   var dateFromUTC: Date? {
       return Formatter.utcFormatter.date(from: self)
   }
}
