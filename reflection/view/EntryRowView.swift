//
//  EntryRowView.swift
//  reflection
//
//  Created by Berfin Orhan on 9.04.2026.
//

import SwiftUI

struct EntryRowView: View {
    
    let entry: Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(entry.mood.title).bold()
            Text(entry.note)
            Text(entry.date.formatted()).foregroundStyle(Color.secondary)
        }
    }
}
