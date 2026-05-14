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
    @State private var mood: Mood
    @State private var date: Date = Date()
    
    let defaultMood: Mood
    let onSave: (Entry) -> Void
    
    init (defaultMood: Mood, onSave: @escaping (Entry) -> Void) {
        self.defaultMood = defaultMood
        self.onSave = onSave
        _mood = State(initialValue: defaultMood)
    }
    
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
        mood = defaultMood
    }
}

#Preview {
    AddEntryView(defaultMood: .great) {_ in}
}
