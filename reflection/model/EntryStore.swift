//
//  EntryStore.swift
//  reflection
//
//  Created by Berfin Orhan on 12.05.2026.
//

import Foundation
import Combine

final class EntryStore: ObservableObject {
    @Published var entries: [Entry] {
        didSet {
            EntryStorage.save(entries)
        }
    }
    
    init() {
        entries = EntryStorage.load()
    }
    
    // For tests
    init (entries: [Entry]) {
        self.entries = entries
    }
    
    func add(_ entry: Entry) {
        entries.append(entry)
    }
    
    func update(_ entry: Entry) {
        if let idx = entries.firstIndex(where: {$0.id == entry.id}) {
            entries[idx] = entry
        }
    }
    
    func delete(_ entry: Entry) {
        entries.removeAll { $0.id == entry.id }
    }

}
