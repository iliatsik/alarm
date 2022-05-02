//
//  WeatherForecast.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import Foundation

struct WeatherForecast : Decodable {
    let forecastday : [ForecastDay]
}

struct ForecastDay : Decodable {
    let astro : Astro
    let hour  : [Hour]
}

struct Astro : Decodable {
    let sunrise : String
    let sunset  : String
}

struct Hour : Decodable {
    let temperature : Double
    let time        : String
    let condition   : Condition
    
    enum CodingKeys: String, CodingKey {
        case time, condition
        case temperature = "temp_c"
    }

}

struct Condition : Codable {
    let icon : String?
    let text : String?
}
