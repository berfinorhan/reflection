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
    let onRequestDelete:(Entry) -> Void
        
    var body: some View {
        ForEach(entries) { entry in
            NavigationLink {
                EditEntryView(entry: entry){ updated in
                    onEdit(updated)
                }
            } label: {
                EntryRowView(entry: entry)
            }.swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button("Delete") {
                    onRequestDelete(entry)
                }.tint(.red)
            }
        }
    }
}

#Preview {
    
}
