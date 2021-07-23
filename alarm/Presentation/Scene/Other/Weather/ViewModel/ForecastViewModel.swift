//
//  ForecastViewModel.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import Foundation


struct ForecastViewModel {
    
    private var weather: Weather
    
    init(weather: Weather) {
        self.weather = weather
    }
 
    var icon : String {
        "\(String(describing: weather.current.condition?.icon))"
    }
    
    var text : String {
        "\(String(describing: weather.current.condition?.text))"
    }
    
    var feelsLike : String {
        "\(String(describing: weather.current.feelslike_c))"
    }
    
    var pressure : String {
        "\(String(describing: weather.current.pressure_mb))"
    }
    
    var windSpeed : String {
        "\(String(describing: weather.current.wind_kph))"
    }
    
    var latitude : String {
        "\(String(describing: weather.location.lat))"
    }

    var longitude : String {
        "\(String(describing: weather.location.lon))"
    }

    var name : String {
        "\(String(describing: weather.location.name))"
    }
    
    var s : String {
        "\(String(describing: weather.forecast.forecastday))"
    }
    
 
   
}

