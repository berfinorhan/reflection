//
//  EntryStats.swift
//  reflection
//
//  Created by Berfin Orhan on 22.05.2026.
//

import Foundation

struct EntryStats {
    let entries: [Entry]
    
    var totalEntryCount: Int {
        entries.count
    }
    
    var moodCounts: [Mood: Int] {
        Dictionary(grouping: entries, by: \.mood)
            .mapValues(\.count)
    }
    
    var mostCommonMoods: [Mood] {
        guard let maxCount = moodCounts.values.max() else { return [] }
        
        return moodCounts.filter { $0.value == maxCount }
            .map { $0.key }
    }
}
