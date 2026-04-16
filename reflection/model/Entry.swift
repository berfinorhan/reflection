//
//  Entry.swift
//  reflection
//
//  Created by Berfin Orhan on 8.04.2026.
//
import Foundation

struct Entry: Identifiable {
    let id: UUID
    let date: Date
    var mood: Mood
    var note: String
    
    init(id: UUID = UUID(), date: Date, mood: Mood, note: String) {
        self.id = id
        self.date = date
        self.mood = mood
        self.note = note
    }
}
