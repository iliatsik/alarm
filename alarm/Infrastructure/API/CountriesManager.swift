//
//  CountriesManager.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import Foundation

protocol CountriesManagerProtocol: AnyObject {
    func fetchCountries(completion: @escaping (([Country]) -> Void))
}

class CountriesManager: CountriesManagerProtocol {
    
    func fetchCountries(completion: @escaping (([Country]) -> Void)) {
        let url = "https://restcountries.eu/rest/v2/all"
        NetworkManager.shared.get(url: url) { (result: Result<[Country], Error>) in
            switch result {
            case .success(let countries):
                completion(countries)
            case .failure(let error):
                print(error)
            }
        }
    }
}
