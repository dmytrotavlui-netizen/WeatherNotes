//
//  LocationService.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    private var locationContinuation: CheckedContinuation<(lat: Double, lon: Double), Error>?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func getCurrentLocation() async throws -> (lat: Double, lon: Double) {
        let status = manager.authorizationStatus
        
        if status == .denied || status == .restricted {
            throw LocationError.unauthorized
        }
        
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            self.locationContinuation = continuation
            manager.requestLocation()
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            locationContinuation?.resume(throwing: LocationError.locationNotFound)
            locationContinuation = nil
            return
        }
        
        locationContinuation?.resume(returning: (lat: location.coordinate.latitude, lon: location.coordinate.longitude))
        locationContinuation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let cle = error as? CLError, cle.code == .denied {
            locationContinuation?.resume(throwing: LocationError.unauthorized)
        } else {
            locationContinuation?.resume(throwing: LocationError.locationNotFound)
        }
        locationContinuation = nil
    }
}
