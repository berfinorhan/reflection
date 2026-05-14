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
    
    @StateObject private var entryStore = EntryStore()
    @StateObject private var appSettings = AppSettings()
    
    @State private var moodFilter: Mood? = nil
    @State private var searchText = ""
    @State private var entryPendingDeletion: Entry?
    @State private var showConfirmation = false
        
    private var sortedEntries: [Entry] {
        entryStore.entries.sorted { $0.date > $1.date }
    }
    
    private var trimmedSearchText: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private var filteredEntries: [Entry] {
        sortedEntries.filter { entry in
            let matchesMood = moodFilter == nil || moodFilter == entry.mood
            let matchesMoodText = entry.mood.title.localizedCaseInsensitiveContains(trimmedSearchText)
            let matchesNoteText = entry.note.localizedCaseInsensitiveContains(trimmedSearchText)
            let matchesSearch = trimmedSearchText.isEmpty || matchesNoteText || matchesMoodText
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
                        entryStore.update(updated)
                    },
                    onRequestDelete: { entry in
                        entryPendingDeletion = entry
                        showConfirmation = true
                    }
                )
            }
            .overlay {
                if entryStore.entries.isEmpty {
                    EmptyListView(title: "No entries", subtitle: "Tap 'Add entry' to get started.")
                } else if filteredEntries.isEmpty && trimmedSearchText.isEmpty {
                    EmptyListView(title: "No results", subtitle: "No entries match your current filter.")
                } else if filteredEntries.isEmpty && !trimmedSearchText.isEmpty {
                    EmptyListView(title: "No results", subtitle: "No entries match your current search.")
                }
            }
            .navigationTitle("History")
            .navigationSubtitle(entryCount)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    MoodFilterPicker(mood: $moodFilter)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("Add entry") {
                        AddEntryView (defaultMood: appSettings.defaultMood) { newEntry in
                            entryStore.add(newEntry)
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingsView(appSettings: appSettings)
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search entries")
        .alert ("Delete entry", isPresented: $showConfirmation) {
            Button("Delete", role: .destructive) {
                if let entryPendingDeletion {
                    entryStore.delete(entryPendingDeletion)
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

#Preview {
    ContentView()
}
