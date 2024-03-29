//
//  WeatherLocation.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import Foundation

struct WeatherLocation : Decodable {
    let name : String
    let lat  : Double
    let lon  : Double
}
