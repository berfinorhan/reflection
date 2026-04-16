//
//  MoodFilterPicker.swift
//  reflection
//
//  Created by Berfin Orhan on 14.04.2026.
//

import SwiftUI

struct MoodFilterPicker: View {
    @Binding var mood: Mood?
    
    var body: some View {
        Picker (selection: $mood, label: Text("Mood")) {
            Text("All").tag(nil as Mood?)
            ForEach(Mood.allCases, id: \.id) { mood in
                Text(mood.title).tag(mood)
            }
        }.pickerStyle(.menu)
    }
}

#Preview {
    MoodFilterPicker(mood: .constant(.great))
}
