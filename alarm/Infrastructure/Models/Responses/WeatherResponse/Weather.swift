//
//  Weather.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import Foundation

struct Weather : Codable {

    let location : WeatherLocation
    let current  : WeatherCurrent
    let forecast : WeatherForecast
    
}
