//
//  Mood.swift
//  reflection
//
//  Created by Berfin Orhan on 8.04.2026.
//

enum Mood: String, CaseIterable {
    case great
    case okay
    case bad
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .great: return "Great"
        case .okay: return "Okay"
        case .bad: return "Bad"
        }
    }
}

