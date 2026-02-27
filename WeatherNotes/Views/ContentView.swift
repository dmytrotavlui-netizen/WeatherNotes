//
//  ContentView.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = ListViewModel()
    @State private var showingAddNote = false
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.notes.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "note.text")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No notes yet. Add one!")
                            .foregroundColor(.secondary)
                    }
                } else {
                    List {
                        ForEach(viewModel.notes) { note in
                            NavigationLink(destination: NoteDetailView(note: note)) {
                                NoteRow(note: note)
                            }
                        }
                        .onDelete(perform: viewModel.deleteNote)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddNote = true
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
            .onAppear {
                viewModel.fetchNotes()
            }
            .sheet(isPresented: $showingAddNote, onDismiss: {
                viewModel.fetchNotes()
            }) {
                AddNoteView()
            }
        }
    }
}


#Preview {
    ContentView()
}
