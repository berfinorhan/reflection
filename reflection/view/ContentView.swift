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
    
    @State private var entries = EntryStorage.load()
    @State private var moodFilter: Mood? = nil
    @State private var searchText = ""
    @State private var entryPendingDeletion: Entry?
    @State private var showConfirmation = false
    
    private var sortedEntries: [Entry] {
        entries.sorted { $0.date > $1.date }
    }
    
    private var filteredEntries: [Entry] {
        sortedEntries.filter { entry in
            let matchesMood = moodFilter == entry.mood || moodFilter == nil
            let matchesMoodText = entry.mood.title.localizedCaseInsensitiveContains(searchText)
            let matchesNoteText = entry.note.localizedCaseInsensitiveContains(searchText)
            let matchesSearch = matchesNoteText || matchesMoodText || searchText.isEmpty
            return matchesMood && matchesSearch
        }
    }
    
    private var entryCount: String {
        let count = filteredEntries.count
        return count == 1 ? "\(count) entry" : "\(count) entries"
    }
        
    var body: some View {
        
        NavigationStack {
            List {
                EntryHistory(
                    entries: filteredEntries,
                    onEdit: { updated in
                        if let idx = entries.firstIndex(where: {$0.id == updated.id}) {
                            entries[idx] = updated
                            EntryStorage.save(entries)
                        }
                    },
                    onRequestDelete: { entry in
                        entryPendingDeletion = entry
                        showConfirmation = true
                    }
                )
            }
            .overlay {
                if entries.isEmpty {
                    EmptyListView(title: "No entries", subtitle: "Tap 'Add entry' to get started.")
                } else if filteredEntries.isEmpty && searchText.isEmpty {
                    EmptyListView(title: "No results", subtitle: "No entries match your current filter.")
                } else if filteredEntries.isEmpty && !searchText.isEmpty {
                    EmptyListView(title: "No results", subtitle: "No entries match your current search.")
                }
            }
            .navigationTitle("History")
            .navigationSubtitle(entryCount)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("Add entry") {
                        AddEntryView { newEntry in
                            entries.append(newEntry)
                            EntryStorage.save(entries)
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    MoodFilterPicker(mood: $moodFilter)
                }
            }
            .searchable(text: $searchText, prompt: "Search entries")
            .alert ("Delete entry", isPresented: $showConfirmation) {
                Button("Delete", role: .destructive) {
                    if let entryPendingDeletion {
                        entries.removeAll { $0.id == entryPendingDeletion.id }
                        EntryStorage.save(entries)
                        self.entryPendingDeletion = nil
                        showConfirmation = false
                    }
                }

                Button("Cancel", role: .cancel) {
                    entryPendingDeletion = nil
                    showConfirmation = false
                }
            } message: {
                Text("Should we get rid of this entry?")
            }
        }
    }
}

#Preview {
    ContentView()
}
