//
//  CovidResponse.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//

import Foundation

struct CovidResponse : Decodable {
    let features : [CovidAttributes]
}
