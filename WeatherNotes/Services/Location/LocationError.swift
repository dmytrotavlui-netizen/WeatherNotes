//
//  LocationError.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import Foundation

enum LocationError: Error, LocalizedError {
    case unauthorized
    case locationNotFound
    
    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Location permission is not allowed. Please enable it in your settings."
        case .locationNotFound:
            return "Unable to determine current location."
        }
    }
}
