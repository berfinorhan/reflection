//
//  EntryStorage.swift
//  reflection
//
//  Created by Berfin Orhan on 11.05.2026.
//

import Foundation

struct EntryStorage {
    private static let entriesKey = "savedEntries"
    
    static func save(_ entries: [Entry]) {
        guard let encodedEntries = try? JSONEncoder().encode(entries) else { return }
        UserDefaults.standard.set(encodedEntries, forKey: entriesKey)
    }
    
    static func load() -> [Entry] {
        guard let savedData = UserDefaults.standard.data(forKey: entriesKey) else { return [] }
        guard let decodedEntries: [Entry] = try? JSONDecoder().decode([Entry].self, from: savedData) else { return [] }
        return decodedEntries
    }
}
