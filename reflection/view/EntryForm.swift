//
//  EntryForm.swift
//  reflection
//
//  Created by Berfin Orhan on 12.04.2026.
//
import SwiftUI

struct EntryForm: View {
    @Binding var note: String
    @Binding var mood: Mood
    @Binding var date: Date
    
    var body: some View {
        TextField("Today is...", text: $note, axis: .vertical)
        
        Picker (selection: $mood, label: Text("Mood")) {
            ForEach(Mood.allCases, id: \.id) { mood in
                Text(mood.title).tag(mood)
            }
        }
        
        DatePicker ("Date", selection: $date)
    }
}

#Preview {
    EntryForm(note: .constant(""), mood: .constant(.great), date: .constant(Date()))
}
