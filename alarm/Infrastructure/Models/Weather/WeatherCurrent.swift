//
//  WeatherCurrent.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import Foundation

struct WeatherCurrent : Codable {
    let feelslike_c : Double?
    let wind_kph    : Double?
    let pressure_mb : Double?
    let condition   : CurrentCondition?
}


struct CurrentCondition : Codable {
    let text : String?
    let icon : String?
}
