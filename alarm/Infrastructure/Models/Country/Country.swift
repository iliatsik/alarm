//
//  Country.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import Foundation

struct Country: Decodable{
    
    let name        : String?
    let capital     : String?
    let region      : String?
    let timezones   : [String]?
    
}
