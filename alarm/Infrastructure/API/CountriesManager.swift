//
//  CountriesManager.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import Foundation
import UIKit

protocol CountriesManagerProtocol: AnyObject {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void)
}

class CountriesManager: CountriesManagerProtocol {
    
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        let url = ApiEndpoints.countryURL
        NetworkManager.shared.get(url: url, completion: completion)
        
    }
}
