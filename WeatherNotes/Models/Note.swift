//
//  Note.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import Foundation

struct Note: Identifiable {
    let id: UUID
    let text: String
    let date: Date
    let temperature: Double
    let weatherDesc: String
    let iconCode: String
}
