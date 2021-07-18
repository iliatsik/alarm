//
//  Covid.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//

import Foundation

struct Covid : Codable {
    let Recovered        : Int?
    let Confirmed        : Int?
    let Deaths           : Int?
    let Active           : Int?
    let Country_Region   : String?
}
