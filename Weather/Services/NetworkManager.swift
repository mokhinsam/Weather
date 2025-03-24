//
//  NetworkManager.swift
//  Weather
//
//  Created by Дарина Самохина on 24.03.2025.
//

import Foundation

enum Link: String {
    case weatherApiURL = "https://api.weatherapi.com/v1/forecast.json?key=5c303c75a38a46ed809102239242904&days=3&q="
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchWeather(from url: String?, completion: @escaping (Result<Weather, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(weather))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
