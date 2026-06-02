//
//  EntryStoreTests.swift
//  reflection
//
//  Created by Berfin Orhan on 21.05.2026.
//

import XCTest
@testable import reflection

final class EntryStoreTests: XCTestCase {
    func testAddAppendsEntry() {
        
        //arrange
        let existingEntry = Entry(date: Date(), mood: .good, note: "This is an existing test entry.")
        let store = EntryStore(entries: [existingEntry])
        let newEntry = Entry(date: Date(), mood: .great, note: "This is a new test entry.")

        //act
        store.add(newEntry)
        
        //verify
        XCTAssertEqual(store.entries.count, 2)
        XCTAssertTrue(store.entries.contains { $0.id == newEntry.id })
    }
    
    func testUpdateReplacesMatchingEntry() {
        
        //arrange
        let existingEntry = Entry(date: Date(), mood: .good, note: "This is an existing test entry.")
        let store = EntryStore(entries: [existingEntry])
        let updatedEntry = Entry(id: existingEntry.id, date: existingEntry.date, mood: .great, note: "This note is updated.")

        //act
        store.update(updatedEntry)
        
        //verify
        XCTAssertEqual(store.entries.count, 1)
        XCTAssertEqual(store.entries[0].mood, .great)
        XCTAssertEqual(store.entries[0].note, "This note is updated.")
    }
    
    func testDeleteRemovesMatchingEntry() {
        
        //arrange
        let existingEntry = Entry(date: Date(), mood: .good, note: "This is an existing test entry.")
        let entryToBeDeleted = Entry(date: Date(), mood: .bad, note: "This is another existing test entry.")
        let store = EntryStore(entries: [existingEntry, entryToBeDeleted])

        //act
        store.delete(entryToBeDeleted)
        
        //verify
        XCTAssertEqual(store.entries.count, 1)
        XCTAssertFalse(store.entries.contains { $0.id == entryToBeDeleted.id })
        XCTAssertTrue(store.entries.contains { $0.id == existingEntry.id })
    }
    
    func testUpdateMissingEntryDoesNotChangeEntries() {
        
        //arrange
        let existingEntry = Entry(date: Date(), mood: .good, note: "This is an existing test entry.")
        let store = EntryStore(entries: [existingEntry])
        let updatedEntry = Entry(date: existingEntry.date, mood: .great, note: "This note is updated.")

        //act
        store.update(updatedEntry)
        
        //verify
        XCTAssertEqual(store.entries.count, 1)
        XCTAssertEqual(store.entries[0].mood, existingEntry.mood)
        XCTAssertEqual(store.entries[0].note, existingEntry.note)
    }
    
    func testDeleteMissingEntryDoesNotChangeEntries() {
        
        //arrange
        let existingEntry = Entry(date: Date(), mood: .bad, note: "This is an existing test entry.")
        let anotherEntry = Entry(date: Date(), mood: .good, note: "This entry doesn't exist in the list.")
        let store = EntryStore(entries: [existingEntry])

        //act
        store.delete(anotherEntry)
        
        //verify
        XCTAssertEqual(store.entries.count, 1)
        XCTAssertTrue(store.entries.contains { $0.id == existingEntry.id })
    }
}
