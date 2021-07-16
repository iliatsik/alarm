//
//  NetworkManager.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func get<T: Codable>(url: String, completion: @escaping ((Result<T, Error>) -> Void)) 
}

class NetworkManager : NetworkManagerProtocol  {
    
    static let shared = NetworkManager()
    
    init() {}
    
    func get<T: Codable>(url: String, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
            
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                print("Error: \(error)")
            }
            
        }.resume()
    }
}
