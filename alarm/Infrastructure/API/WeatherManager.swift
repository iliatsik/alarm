//
//  WeatherManager.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import Foundation
import CoreLocation

protocol WeatherManagerProtocol: AnyObject {
    func fetchWeatherLocation(with cityname: String, completion: @escaping (Result<(Weather), Error>) -> Void)
}

class WeatherManager : WeatherManagerProtocol {

    
    func fetchWeatherLocation(with cityname: String, completion: @escaping (Result<(Weather), Error>) -> Void) {

        let url = ApiEndpoints.weatherURL + cityname
        NetworkManager.shared.get(url: url, completion: completion)
    }
}
