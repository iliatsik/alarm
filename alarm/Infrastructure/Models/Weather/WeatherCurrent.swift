//
//  WeatherCurrent.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import Foundation

struct WeatherCurrent : Decodable {
    let feelslike   : Double
    let windSpeed   : Double
    let pressure    : Double
    let condition   : CurrentCondition
    let humidity    : Int
    let temperature : Int
    
    enum CodingKeys: String, CodingKey {
        case feelslike   = "feelslike_c"
        case windSpeed   = "wind_kph"
        case pressure    = "pressure_mb"
        case temperature = "temp_c"
        case condition, humidity
    }
}


struct CurrentCondition : Decodable {
    let text : String
    let icon : String
}
