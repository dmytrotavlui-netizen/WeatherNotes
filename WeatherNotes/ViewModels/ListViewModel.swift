//
//  ListViewModel.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import Combine
import Foundation

@MainActor
class ListViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    func fetchNotes() {
        do {
            notes = try StorageService.shared.fetchNotes()
        } catch {
            print("Error downloading from Core Data: \(error)")
        }
    }
    
    func deleteNote(at offsets: IndexSet) {
        for index in offsets {
            let note = notes[index]
            do {
                try StorageService.shared.deleteNote(with: note.id)
            } catch {
                print("Deleting error: \(error)")
            }
        }
        
        fetchNotes()
    }
}
