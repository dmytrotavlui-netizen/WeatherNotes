//
//  AddNoteView.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import SwiftUI

struct AddNoteView: View {
    @StateObject private var viewModel = AddNoteViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("What are you doing now?", text: $viewModel.noteText)
                
                Button(action: {
                    viewModel.saveNote {
                        dismiss()
                    }
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Save")
                    }
                }
                .disabled(viewModel.noteText.isEmpty || viewModel.isLoading)
            }
            .navigationTitle("New note")
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "Unexpected error")
            }
        }
    }
}
