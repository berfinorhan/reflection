//
//  AddEntryView.swift
//  reflection
//
//  Created by Berfin Orhan on 9.04.2026.
//

import SwiftUI

struct AddEntryView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var note: String = ""
    @State private var mood: Mood = Mood.great
    @State private var date: Date = Date()
    let onSave: (Entry) -> Void
    
    var body: some View {
        Form {
            EntryForm(note: $note, mood: $mood, date: $date)
            
            Button("Add Entry") {
                let newEntry = Entry(date: date, mood: mood, note: note)
                if !newEntry.isEmpty {
                    onSave(newEntry)
                    clearNoteState()
                    dismiss()
                }
            }.buttonStyle(.borderedProminent)
                .tint(Color.yellow)
        }.navigationTitle("Add Entry")
    }
    
    func clearNoteState () {
        note = ""
        mood = .great
    }
}

#Preview {
    AddEntryView() {_ in}
}
