//
//  ContentView.swift
//  reflection
//
//  Created by Berfin Orhan on 6.04.2026.
//

import SwiftUI

struct ContentView: View {
    
    /**
     Screens to develop:
     - Home
     - Add Entry [done]
     - History [done]
     - Settings
    */
    
    @State private var entries = [
        Entry (
        id: UUID(),
        date: Date(),
        mood: Mood.okay,
        note: "Today was not bad at all."
    ), Entry (
        id: UUID(),
        date: Date(),
        mood: Mood.bad,
        note: "Today was not good :/"
    ), Entry (
        id: UUID(),
        date: Date(),
        mood: Mood.great,
        note: "Today was great actually :o")
    ]
    
//    @State private var entries: [Entry] = []
    
    @State private var moodFilter: Mood? = nil
    
    private var sortedEntries: [Entry] {
        entries.sorted { $0.date > $1.date }
    }
    
    private var filteredEntries: [Entry] {
        guard let moodFilter = moodFilter else { return sortedEntries }
        return sortedEntries.filter { $0.mood == moodFilter }
    }
    
    var body: some View {
        
        NavigationStack {
            List {
                EntryHistory(
                    entries: filteredEntries,
                    onEdit: { updated in
                        if let idx = entries.firstIndex(where: {$0.id == updated.id}) {
                            entries[idx] = updated
                        }
                    },
                    onDelete: { ids in
                        entries.removeAll { ids.contains($0.id) }
                    }
                )
            }.overlay {
                if entries.isEmpty {
                    EmptyListView(title: "No entries", subtitle: "Tap 'Add entry' to get started.")
                } else if filteredEntries.isEmpty {
                    EmptyListView(title: "No entries", subtitle: "No entries match your current filter.")
                }
            }
            .navigationTitle("History")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("Add entry") {
                        AddEntryView { newEntry in
                            entries.append(newEntry)
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    MoodFilterPicker(mood: $moodFilter)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
