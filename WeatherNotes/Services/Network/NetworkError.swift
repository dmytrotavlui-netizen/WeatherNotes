//
//  NetworkError.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case requestFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Wrong URL."
        case .invalidResponse:
            return "Unexpected response from server."
        case .decodingFailed:
            return "Error handling weather data."
        case .requestFailed(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}
