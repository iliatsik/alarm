//
//  CovidManager.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//

import Foundation

protocol CovidManagerProtocol: AnyObject {
    func fetchCovidStats(completion: @escaping ((Result<CovidResponse, Error>) -> Void))
}

class CovidManager : CovidManagerProtocol {
    
    func fetchCovidStats(completion: @escaping ((Result<CovidResponse, Error>) -> Void)) {
        let url = ApiEndpoints.covidURL

        NetworkManager.shared.get(url: url, completion: completion)
    }
    
    
}
