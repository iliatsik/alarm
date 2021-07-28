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
    
    var name : String {
        "\(covid.Country_Region ?? "Georgia")"
    }
    
    var confirmed: Int {
        covid.Confirmed ?? 0
    }
    
    var active: Int {
        covid.Active ?? 0
    }
    
    var death: Int {
        covid.Deaths ?? 0
    }

    var recovered : Int {
        covid.Recovered ?? 0
    }
    
    var mortalityRate : Double {
        Double( round (1000 * (covid.Mortality_Rate ?? 0.0)) / 1000)
    }
    
    var incidentRate : Double {
        Double( round (1000 * (covid.Incident_Rate ?? 0.0)) / 1000)
    }
    
}
