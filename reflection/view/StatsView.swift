//
//  StatsView.swift
//  reflection
//
//  Created by Berfin Orhan on 14.05.2026.
//

import SwiftUI

struct StatsView: View {
    
    let entries: [Entry]
    
    private var entryStats: EntryStats {
        EntryStats(entries: entries)
    }
    
    private var mostCommonMoodText: String {
        let moods = entryStats.mostCommonMoods

        if moods.isEmpty {
            return "No moods yet"
        } else if moods.count == 1 {
            return moods[0].title
        } else {
            return moods.map(\.title).joined(separator: ", ")
        }
    }
    
    var body: some View {
        
        NavigationStack {
            if entries.isEmpty {
                EmptyListView(title: "No entries", subtitle: "Add entries to see your stats.")
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        SummaryCard(totalEntryCount: entryStats.totalEntryCount, mostCommonMood: mostCommonMoodText)
                        MoodBreakdownCard(moodCounts: entryStats.moodCounts)
                    }
                }
                .padding()
                .background(Color(.systemGroupedBackground))
                .navigationTitle("Stats")
            }
        }
    }
}

struct SummaryCard: View {
    
    let totalEntryCount: Int
    let mostCommonMood: String
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Summary").font(Font.headline)
            Divider()
            LabeledContent("Total entry count", value: String(totalEntryCount))
            LabeledContent("Most common mood", value: mostCommonMood)
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

struct MoodBreakdownCard: View {
    
    let moodCounts: [Mood: Int]
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Your moods, sorted by count").font(Font.headline)
            Divider()
            ForEach(Mood.allCases, id: \.id) { mood in
                let moodCount = moodCounts[mood] ?? 0
                LabeledContent("\(mood.title)", value: "\(moodCount)")
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    //StatsView()
}
