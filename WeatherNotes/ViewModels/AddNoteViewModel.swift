//
//  AddNoteViewModel.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import Combine
import Foundation

@MainActor
final class AddNoteViewModel: ObservableObject {
    @Published var noteText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    
    @Published var isLocationError: Bool = false
    
    func saveNote(onSuccess: @escaping () -> Void) {
        guard !noteText.isEmpty else { return }
        
        isLoading = true
        isLocationError = false
        
        Task {
            do {
                let coords = try await LocationService.shared.getCurrentLocation()
                let weather = try await WeatherService.shared.fetchWeather(lat: coords.lat, lon: coords.lon)
                
                let weatherDesc = weather.weather.first?.description ?? "No data"
                let iconCode = weather.weather.first?.icon ?? ""
                
                try StorageService.shared.saveNote(
                    text: noteText,
                    temperature: weather.main.temp,
                    weatherDesc: weatherDesc,
                    iconCode: iconCode
                )
                
                isLoading = false
                onSuccess()
                
            } catch {
                isLoading = false
                errorMessage = error.localizedDescription
                
                if let locationError = error as? LocationError, locationError == .unauthorized {
                    isLocationError = true
                }
                
                showAlert = true
            }
        }
    }
}
