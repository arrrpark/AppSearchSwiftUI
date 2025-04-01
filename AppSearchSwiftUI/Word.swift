//
//  Item.swift
//  AppSearchSwiftUI
//
//  Created by Park on 2025-03-31.
//

import Foundation
import SwiftData

@Model
final class Word {
    @Attribute(.unique) var word: String
    var timestamp: Date
    
    init(word: String, timestamp: Date) {
        self.word = word
        self.timestamp = timestamp
    }
}
