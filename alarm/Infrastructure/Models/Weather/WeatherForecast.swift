//
//  WeatherForecast.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import Foundation

struct WeatherForecast : Codable {
    let forecastday : [ForecastDay]?
}

struct ForecastDay : Codable {
    let astro : Astro?
    let hour  : [Hour]?
}

struct Astro : Codable {
    let sunrise : String?
    let sunset  : String?
}

struct Hour : Codable {
    let temp_c    : String?
    let time      : String?
    let condition : Condition?
}

struct Condition : Codable {
    let icon : String?
    let text : String?
}
