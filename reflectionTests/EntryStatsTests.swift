//
//  EntryStatsTests.swift
//  reflection
//
//  Created by Berfin Orhan on 22.05.2026.
//

import XCTest
@testable import reflection

final class EntryStatsTests: XCTestCase {
    
    func testTotalEntryCount() {
        let entry1 = Entry(date: Date(), mood: .good, note: "Test 1")
        let entry2 = Entry(date: Date(), mood: .okay, note: "Test 2")
        let entries = [entry1, entry2]
        
        let expectedCount = 2
        let actualCount = EntryStats(entries: entries).totalEntryCount
        
        XCTAssertEqual(expectedCount, actualCount)
    }
    
    func testMoodCounts() {
        let entry1 = Entry(date: Date(), mood: .good, note: "Test 1")
        let entry2 = Entry(date: Date(), mood: .okay, note: "Test 2")
        let entry3 = Entry(date: Date(), mood: .good, note: "Test 3")
        let entries = [entry1, entry2, entry3]
        
        let expectedCounts: [Mood: Int] = [
            .good: 2,
            .okay: 1
        ]
        let actualCounts = EntryStats(entries: entries).moodCounts
        
        XCTAssertEqual(expectedCounts, actualCounts)
    }
    
    func testMostCommonMood() {
        let entry1 = Entry(date: Date(), mood: .good, note: "Test 1")
        let entry2 = Entry(date: Date(), mood: .okay, note: "Test 2")
        let entry3 = Entry(date: Date(), mood: .good, note: "Test 3")
        let entries = [entry1, entry2, entry3]
        
        let expectedMostCommonMoods: [Mood] = [.good]
        let actualMostCommonMoods: [Mood] = EntryStats(entries: entries).mostCommonMoods
        
        XCTAssertEqual(expectedMostCommonMoods, actualMostCommonMoods)
    }
    
    
    func testMoodCountsWithEmptyList() {
        let entries: [Entry] = []
        
        let expectedMoodCount: [Mood: Int] = [:]
        let actualMoodCount = EntryStats(entries: entries).moodCounts
        
        XCTAssertEqual(expectedMoodCount, actualMoodCount)
    }
    
    func testMostCommonMoodWithEmptyList() {
        let entries: [Entry] = []
        
        let expectedMostCommonMood: [Mood] = []
        let actualMostCommonMood = EntryStats(entries: entries).mostCommonMoods
        
        XCTAssertEqual(expectedMostCommonMood, actualMostCommonMood)
    }
    
    func testMostCommonMoodWithEqualMoods() {
        let entries: [Entry] = [
            Entry(date: Date(), mood: .good, note: "Test 1"),
            Entry(date: Date(), mood: .okay, note: "Test 2"),
            Entry(date: Date(), mood: .bad, note: "Test 3")]
        
        let expectedMostCommonMoods: [Mood] = [.good, .okay, .bad]
        let actualMostCommonMoods: [Mood] = EntryStats(entries: entries).mostCommonMoods
        
        XCTAssertEqual(Set(expectedMostCommonMoods), Set(actualMostCommonMoods))
    }
}
