//
//  CovidManager.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//

import Foundation

protocol CovidManagerProtocol: AnyObject {
    func fetchCovidStats(completion: @escaping ((Result<[Covid], Error>) -> Void))
}

class CovidManager : CovidManagerProtocol {
    
    func fetchCovidStats(completion: @escaping ((Result<[Covid], Error>) -> Void)) {
        let url = "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases2_v1/FeatureServer/2/query?where=1%3D1&outFields=*&outSR=4326&f=json"
        NetworkManager.shared.get(url: url) { (result: Result<CovidResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.features))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
