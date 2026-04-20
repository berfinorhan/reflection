//
//  EditEntryView.swift
//  reflection
//
//  Created by Berfin Orhan on 12.04.2026.
//

import SwiftUI

struct EditEntryView: View {
    let entry: Entry
    let onSave: (Entry) -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var note: String
    @State private var mood: Mood
    @State private var date: Date
    
    init(entry: Entry, onSave: @escaping (Entry) -> Void) {
        self.entry = entry
        self.onSave = onSave
        _note = State(initialValue: entry.note)
        _mood = State(initialValue: entry.mood)
        _date = State(initialValue: entry.date)
    }
    
    var body: some View {
        Form {
            EntryForm(note: $note, mood: $mood, date: $date)
            
            Button("Save") {
                let updatedEntry = Entry(id: entry.id, date: date, mood: mood, note: note)
                if !updatedEntry.isEmpty {
                    onSave(updatedEntry)
                    dismiss()
                }
            }.buttonStyle(.borderedProminent)
                .tint(Color.yellow)
        }.navigationTitle("Edit Entry")
        
    }
}

#Preview {
    EditEntryView (entry: Entry(date: Date(), mood: .great, note: "Test note, hi"), onSave: {_ in })
}
