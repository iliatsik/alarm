//
//  Covid.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//

import Foundation

struct Covid : Codable {
    
    let Country_Region   : String?
    let Confirmed        : Int?
    let Active           : Int?
    let Recovered        : Int?
    let Deaths           : Int?
    let Incident_Rate    : Double?
    let Mortality_Rate   : Double?
    
}

