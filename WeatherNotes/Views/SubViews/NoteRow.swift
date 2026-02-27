//
//  NoteRow.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import SwiftUI

struct NoteRow: View {
    let note: Note
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: note.date)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(note.text)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(formattedDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack(spacing: 8) {
                Text("\(Int(note.temperature))°C")
                    .font(.title3)
                    .fontWeight(.medium)
                
                if !note.iconCode.isEmpty,
                   let url = URL(string: "https://openweathermap.org/img/wn/\(note.iconCode)@2x.png") {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 45, height: 45)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
