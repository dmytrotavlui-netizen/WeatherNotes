//
//  NetworkService.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import Foundation

class WeatherService {
    static let shared = WeatherService()
    
    private let apiKey = "ef128624f9c62c10125464e19ec5a165"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponse {
        let urlString = "\(baseURL)?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherResponse.self, from: data)
            
        } catch let error as URLError {
            throw NetworkError.requestFailed(error)
        } catch is DecodingError {
            throw NetworkError.decodingFailed
        } catch {
            throw error
        }
    }
}
