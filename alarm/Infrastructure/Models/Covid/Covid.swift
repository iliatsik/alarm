//
//  Covid.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//

import Foundation

struct Covid : Decodable {
    
    let countryRegion   : String?
    let confirmed       : Int?
    let active          : Int?
    let recovered       : Int?
    let death           : Int?
    let incidentRate    : Double?
    let mortalityRate   : Double?
    
    enum CodingKeys: String, CodingKey {
        case countryRegion = "Country_Region"
        case confirmed     = "Confirmed"
        case active        = "Active"
        case recovered     = "Recovered"
        case death         = "Deaths"
        case incidentRate  = "Incident_Rate"
        case mortalityRate = "Mortality_Rate"
    }
}

