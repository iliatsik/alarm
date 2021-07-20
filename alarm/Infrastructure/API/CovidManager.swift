//
//  CovidManager.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//

import Foundation

protocol CovidManagerProtocol: AnyObject {
    func fetchCovidStats(completion: @escaping (([Covid]) -> Void))
}

class CovidManager : CovidManagerProtocol {
    
    func fetchCovidStats(completion: @escaping (([Covid]) -> Void)) {
        let url = "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases2_v1/FeatureServer/2/query?where=1%3D1&outFields=*&outSR=4326&f=json"
        NetworkManager.shared.get(url: url) { (result: Result<CovidResponse, Error>) in
            switch result {
            case .success(let response):
                print(response.features.map { $0.attributes[0] })
                completion(response.features.map { $0.attributes[0] })
            case .failure(let err):
                print(err)
            }
        }
    }
}
