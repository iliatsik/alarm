//
//  CovidViewModel.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 19.07.21.
//

import Foundation

struct CovidViewModel {
    
    private var covid: Covid
    
    init(covid: Covid) {
        self.covid = covid
    }
    
    var active: String {
        "\(covid.Active ?? 0)"
    }
    
    var death: String {
        "\(covid.Deaths ?? 0)"
    }
    
    var confirmed: String {
        "\(covid.Confirmed ?? 0)"
    }
    
    var name : String {
        "\(covid.Country_Region ?? "")"
    }
 
    var recovered : String {
        "\(covid.Recovered ?? 0)"
    }
    
    var mortalityRate : String {
        "\(covid.Mortality_Rate ?? 0.0)"
    }
    
    var incidentRate : String {
        "\(covid.Incident_Rate ?? 0.0)"
    }
}
