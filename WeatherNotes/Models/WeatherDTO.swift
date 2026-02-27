//
//  WeatherDTO.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: MainWeather
    let weather: [WeatherDescription]
}

struct MainWeather: Decodable {
    let temp: Double
    enum CodingKeys: String, CodingKey {
        case temp
    }
}

struct WeatherDescription: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
