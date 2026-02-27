//
//  StorageService.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import CoreData

class StorageService {
    static let shared = StorageService()
    
    private let container: NSPersistentContainer
    private var context: NSManagedObjectContext {
        container.viewContext
    }
    
    init() {
        container = NSPersistentContainer(name: "WeatherNotes")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error with loading Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchNotes() throws -> [Note] {
        let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \NoteEntity.date, ascending: false)]
        
        let entities = try context.fetch(request)
        
        return entities.map { entity in
            Note(
                id: entity.id ?? UUID(),
                text: entity.text ?? "",
                date: entity.date ?? Date(),
                temperature: entity.temperature,
                weatherDesc: entity.weatherDesc ?? "",
                iconCode: entity.iconCode ?? ""
            )
        }
    }
    
    func saveNote(text: String, temperature: Double, weatherDesc: String, iconCode: String) throws {
        let newNote = NoteEntity(context: context)
        newNote.id = UUID()
        newNote.date = Date()
        newNote.text = text
        newNote.temperature = temperature
        newNote.weatherDesc = weatherDesc
        newNote.iconCode = iconCode
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func deleteNote(with id: UUID) throws {
        let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        
        if let entityToDelete = try context.fetch(request).first {
            context.delete(entityToDelete)
            
            if context.hasChanges {
                try context.save()
            }
        }
    }
}
