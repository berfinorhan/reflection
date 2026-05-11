//
//  Mood.swift
//  reflection
//
//  Created by Berfin Orhan on 8.04.2026.
//

enum Mood: String, CaseIterable, Codable {
    case great
    case good
    case okay
    case bad
    case terrible
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .great: return "Great"
        case .good: return "Good"
        case .okay: return "Okay"
        case .bad: return "Bad"
        case .terrible: return "Terrible"
        }
    }
}

