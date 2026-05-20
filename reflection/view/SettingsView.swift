//
//  SettingsView.swift
//  reflection
//
//  Created by Berfin Orhan on 13.05.2026.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var appSettings: AppSettings
    
    var body: some View {
        NavigationStack {
            Form {
                Picker (selection: $appSettings.defaultMood, label: Text("Default mood")) {
                    ForEach(Mood.allCases, id: \.id) { mood in
                        Text(mood.title).tag(mood)
                    }
                }.pickerStyle(.menu)
            }.navigationTitle("Settings")
        }
    }
}

#Preview {
    
}
