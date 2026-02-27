//
//  NoteDetailView.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import SwiftUI

struct NoteDetailView: View {
    let note: Note
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: note.date)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                VStack(spacing: 8) {
                    if !note.iconCode.isEmpty,
                       let url = URL(string: "https://openweathermap.org/img/wn/\(note.iconCode)@4x.png") {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 150, height: 150)
                    }
                    
                    Text("\(Int(note.temperature))°C")
                        .font(.system(size: 64, weight: .bold))
                    
                    Text(note.weatherDesc.capitalized)
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                Divider()
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(formattedDate)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(note.text)
                        .font(.body)
                        .lineSpacing(4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            }
        }
        .navigationTitle("Note")
        .navigationBarTitleDisplayMode(.inline)
    }
}
