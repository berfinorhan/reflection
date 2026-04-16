//
//  EmptyListView.swift
//  reflection
//
//  Created by Berfin Orhan on 14.04.2026.
//

import SwiftUI

struct EmptyListView: View {
    let title: String
    let subtitle: String?
    
    var body: some View {
        VStack {
            Image(systemName: "arrow.2.circlepath.circle").padding(2)
            Text(title)
                .font(.headline)
            if let subtitle {
                Text(subtitle)
                    .font(.subheadline)
            }
        }.multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    EmptyListView(title: "No result", subtitle: "Try removing any filters, or adding a new entry")
}
