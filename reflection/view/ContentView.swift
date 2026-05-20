//
//  ContentView.swift
//  reflection
//
//  Created by Berfin Orhan on 6.04.2026.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var entryStore = EntryStore()
    @StateObject private var appSettings = AppSettings()
        
    var body: some View {
        
        TabView {
            HistoryView(entryStore: entryStore, appSettings: appSettings)
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }
            
            StatsView(entries: entryStore.entries)
                .tabItem {
                    Label("Stats", systemImage: "chart.bar")
                }
            
            SettingsView(appSettings: appSettings)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        
    }
}

#Preview {
    ContentView()
}
