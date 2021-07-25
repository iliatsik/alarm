//
//  WeatherManager.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import Foundation
import CoreLocation

protocol WeatherManagerProtocol: AnyObject {
    func fetchWeatherLocation(with cityname: String, completion: @escaping ((Weather) -> Void))
}

class WeatherManager : WeatherManagerProtocol {

    
    func fetchWeatherLocation(with cityname: String, completion: @escaping ((Weather) -> Void)) {

        let url = "https://api.weatherapi.com/v1/forecast.json?key=45925ef3d954456680580528212107&q=\(cityname)&days=1&aqi=no&alerts=no"

        NetworkManager.shared.get(url: url) { (result: (Result<(Weather), Error>)) in
            switch result {
            case .success(let response):
                print(response)
                completion(response)
                
            case .failure(let err):
                print(err)
            }
        }
    }
}
