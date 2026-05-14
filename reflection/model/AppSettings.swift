//
//  AppSettings.swift
//  reflection
//
//  Created by Berfin Orhan on 13.05.2026.
//

import Foundation
import Combine

final class AppSettings: ObservableObject {
    
    @Published var defaultMood: Mood {
        didSet {
            Self.save(defaultMood)
        }
    }
    
    private static let defaultMoodKey = "defaultMood"
    
    init() {
        defaultMood = Self.load()
    }
    
    static func save(_ defaultMood: Mood) {
        UserDefaults.standard.set(defaultMood.rawValue, forKey: defaultMoodKey)
    }
    
    static func load() -> Mood {
        guard let savedMoodRawValue = UserDefaults.standard.string(forKey: defaultMoodKey) else { return .good }
        guard let mood = Mood(rawValue: savedMoodRawValue) else { return .good }
        return mood
    }
}
