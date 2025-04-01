//
//  WordDAO.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import SwiftData
import SwiftUI

final class WordDAO {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func insertWord(_ word: Word) throws {
        if let word = fetchWord(word.word) {
            word.timestamp = .now
            try modelContext.save()
            return
        }
        
        if var words = fetchWords(),
           words.count > 4 {
            words = words.sorted { $0.timestamp > $1.timestamp }
            let wordToDelete = words[words.count - 1]
            modelContext.delete(wordToDelete)
        }
        
        modelContext.insert(word)
        try modelContext.save()
    }
    
    func fetchWords() -> [Word]? {
        let descriptor = FetchDescriptor<Word>()
        return (try? modelContext.fetch(descriptor)) ?? nil
    }
    
    func fetchWord(_ word: String) -> Word? {
        let descriptor = FetchDescriptor<Word>(predicate: #Predicate { $0.word == word })
        return (try? modelContext.fetch(descriptor).first) ?? nil
    }
    
}
