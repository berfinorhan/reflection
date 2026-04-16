//
//  EntryHistory.swift
//  reflection
//
//  Created by Berfin Orhan on 14.04.2026.
//

import SwiftUI

struct EntryHistory: View {
    
    let entries: [Entry]
    let onEdit: (Entry) -> Void
    let onDelete: (Set<UUID>) -> Void
        
    var body: some View {
        ForEach(entries) { entry in
            NavigationLink {
                EditEntryView(entry: entry){ updated in
                    onEdit(updated)
                }
            } label: {
                EntryRowView(entry: entry)
            }
        }.onDelete { indexSet in
            let ids = Set(indexSet.map { entries[$0].id })
            onDelete(ids)
        }
    }
}

#Preview {
    
}
